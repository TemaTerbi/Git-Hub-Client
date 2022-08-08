//
//  Login.swift
//  GitHubClient
//
//  Created by TeRb1 on 08.08.2022.
//

import Foundation

struct Login: Codable {
    var access_token: String?
    var scope: String?
    var token_type: String?
}
