//
//  APIResponse.swift
//  week5_practice
//
//  Created by 황민지 on 10/22/25.
//

import Foundation

struct APIResponse: Codable {
    let status: String
    let message: String
    let data: UserData
}

struct UserData: Codable {
    let users: [UserDTO]
}
