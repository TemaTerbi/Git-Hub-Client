
import Foundation

struct Repositories: Codable {
    var id: Int
    var name: String
    var full_name: String
    var owner: Owner?
    var description: String?
    var forks_count: Int
    var watchers_count: Int
}

struct Owner: Codable {
    var login: String
    var avatar_url: String
}

