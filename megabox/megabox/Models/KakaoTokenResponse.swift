//
//  KakaoTokenResponse.swift
//  megabox
//
//  Created by 황민지 on 11/13/25.
//

import Foundation

struct KakaoTokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
