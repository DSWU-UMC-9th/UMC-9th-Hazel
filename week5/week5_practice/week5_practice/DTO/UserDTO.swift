//
//  UserDTO.swift
//  week5_practice
//
//  Created by 황민지 on 10/22/25.
//

import Foundation

// API 응답을 받을 DTO
struct UserDTO: Codable {
    let userId: String
    let name: String
    let profileImage: String?
    let userBio: String
    let createdAt: String
    
    // Codable을 위한 CodingKeys
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name = "user_name"
        case profileImage = "profile_image"
        case userBio = "user_bio"
        case createdAt = "created_at"
    }
}

// 1. 직접 매핑
//extension UserDTO {
//    // DTO를 도메인 모델로 변환
//    func toDomain() -> UserModel {
//        return UserModel(
//            id: userId,
//            name: name,
//            profileImageURL: profileImage,
//            bio: userBio
//        )
//    }
//}

// 2. Mapper 구조 분리 매핑
struct UserMapper {
    static func toDomain(from dto: UserDTO) -> UserModel {
        return UserModel(
            id: dto.userId,
            name: dto.name,
            profileImageURL: dto.profileImage,
            bio: dto.userBio
        )
    }
    
    static func toDTO(from domain: UserModel) -> UserDTO {
        return UserDTO(
            userId: domain.id,
            name: domain.name,
            profileImage: domain.profileImageURL,
            userBio: domain.bio,
            createdAt: ISO8601DateFormatter().string(from: Date())
        )
    }
    // 복잡한 매핑 로직
    static func toDomainList(from dtos: [UserDTO]) -> [UserModel] {
        return dtos.map { toDomain(from: $0) }
    }
}

