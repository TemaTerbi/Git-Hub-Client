//
//  API.swift
//  GitHubClient
//
//  Created by TeRb1 on 08.08.2022.
//

import Foundation
import UIKit

private let storage = UserDefaults.standard


enum ApiType {
    var getUserCode: String {
        return UserDefaults.standard.string(forKey: "UserAuthCode") ?? ""
    }
    
    var getAccessToken: String {
        return UserDefaults.standard.string(forKey: "AccessToken") ?? ""
    }
    
    var getLogin: String {
        return UserDefaults.standard.string(forKey: "Login") ?? ""
    }
    
    var getNameOfRepos: String {
        return UserDefaults.standard.string(forKey: "nameOfRepo") ?? ""
    }
    
    case getUserRepos
    case postLogin
    case repositories
    case commits
    case logOut
    
    var baseUrl: String {
        return "https://api.github.com/"
    }
    
    var headers: [String: String] {
        switch self {
        default:
            return [:]
        }
    }
    
    var userCode: String {
        return getUserCode
    }
    
    var accessToken: String {
        return getAccessToken
    }
    
    var login: String {
        return getLogin
    }
    
    var repositories: String {
        return getNameOfRepos
    }
    
    var path: String {
        switch self {
        case .getUserRepos:
            return "user/repos"
        case .postLogin:
            return ""
        case .repositories:
            return "user/repos"
        case .commits:
            return "repos/\(login)/\(repositories)/commits"
        case .logOut:
            return "applications/17bdb8071f045ddcbda8/grant"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseUrl)!)!
        var request = URLRequest(url: url)
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.allHTTPHeaderFields = headers
        switch self {
        default:
            request.httpMethod = "GET"
            return request
        }
    }
    
    var requestDelete: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseUrl)!)!
        var request = URLRequest(url: url)
        request.setValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.allHTTPHeaderFields = headers
        switch self {
        default:
            request.httpMethod = "DELETE"
            return request
        }
    }
    
    var defaultRequest: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseUrl)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
        default:
            request.httpMethod = "GET"
            return request
        }
    }
    
    var requestPost: URLRequest {
        let url = URL(string: "https://github.com/login/oauth/access_token?client_id=17bdb8071f045ddcbda8&client_secret=01a9febeac13b6438d74b35a2dd86eb38010a462&code=\(userCode)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = [:]
        return request
    }
}

final class ApiManager {
    
    static let shared = ApiManager()
    
    func postUserLogin() {
        let request = ApiType.postLogin.requestPost
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                let withoutAccesTokenParam = dataString?.replacingOccurrences(of: "access_token=", with: "")
                let accessToken = withoutAccesTokenParam?.replacingOccurrences(of: "&scope=&token_type=bearer", with: "") ?? ""
                UserDefaults.standard.set(accessToken, forKey: "AccessToken")
                print("ACCESS TOKEN WAS SET " + accessToken)
            } else {
                print("Network Error: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
    }
    
    func getRepositories(completion: @escaping ([Repositories]) -> Void) {
        let request = ApiType.repositories.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let repositories = try? JSONDecoder().decode([Repositories].self, from: data) {
                    completion(repositories)
                } else {
                    print("Parsing Error")
                }
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
    func getCommits(completion: @escaping ([Commits]) -> Void) {
        let request = ApiType.commits.defaultRequest
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let commits = try? JSONDecoder().decode([Commits].self, from: data) {
                    completion(commits)
                } else {
                    print("Parsing Error")
                }
            } else {
                print(error)
            }
        }
        task.resume()
    }
}

