//
//  UserInfoModel.swift
//  megabox
//
//  Created by 황민지 on 9/27/25.
//

// keychain 등록 -> 로그인 아이디, 비밀번호 정의
import Foundation

struct UserInfoModel :Codable{
    var id: String
    var password: String
}
