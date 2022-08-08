//
//  Commits.swift
//  GitHubClient
//
//  Created by TeRb1 on 08.08.2022.
//

import Foundation


struct Commits: Codable {
    var sha: String
    var commit: Commit?
}

struct Commit: Codable {
    var message: String
    var author: Author
}

struct Author: Codable {
    var name: String
    var date: String
}
