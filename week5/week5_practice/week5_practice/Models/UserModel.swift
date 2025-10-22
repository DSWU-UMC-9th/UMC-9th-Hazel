//
//  UserModel.swift
//  week5_practice
//
//  Created by 황민지 on 10/22/25.
//

import Foundation

struct UserModel: Codable {
    let id: String
    let name: String
    let profileImageURL: String?
    let bio: String
    
    // 도메인 로직 : 프로필이 완성되었는지 여부 확인
    var isProfileComplete: Bool {
        !name.isEmpty && !bio.isEmpty
    }
    
    // 도메인 로직 : 표시용 이름 생성
    var displayName: String {
        name.isEmpty ? "익명의 사용자" : name
    }
}
