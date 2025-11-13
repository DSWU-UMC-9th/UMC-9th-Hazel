//
//  KakaoUserInfoResponse.swift
//  megabox
//
//  Created by 황민지 on 11/13/25.
//

import Foundation

/// 카카오 사용자 정보 API (/v2/user/me) 응답 모델
struct KakaoUserInfoResponse: Decodable {
    let id: Int
    let kakaoAccount: KakaoAccount?
    let properties: KakaoUserProperties?
    
    enum CodingKeys: String, CodingKey {
        case id
        case kakaoAccount = "kakao_account"
        case properties
    }
}

/// 사용자 계정 정보
struct KakaoAccount: Decodable {
    let profile: KakaoProfile?
    
    enum CodingKeys: String, CodingKey {
        case profile
    }
}

/// 프로필 정보 (닉네임, 프로필 이미지)
struct KakaoProfile: Decodable {
    let nickname: String?
    let profileImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case nickname
        case profileImageURL = "profile_image_url"
    }
}

/// properties 필드 (기본 프로필 데이터)
struct KakaoUserProperties: Decodable {
    let nickname: String?
}
