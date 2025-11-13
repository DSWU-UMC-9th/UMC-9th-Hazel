//
//  KakaoAuthManager.swift
//  megabox
//
//  Created by 황민지 on 11/13/25.
//

import Foundation
import Alamofire

class KakaoAuthManager {
    static let shared = KakaoAuthManager()
    private init() {}
    
    private let restApiKey = "d7f24cfab377fafef4c5f9f66cecd7f0"
    private let redirectURI = "megabox://oauth"
    
    func requestTokenWithAlamofire(code: String) {
        let url = "https://kauth.kakao.com/oauth/token"
        let params: [String: String] = [
            "grant_type": "authorization_code",
            "client_id": restApiKey,
            "redirect_uri": redirectURI,
            "code": code
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: URLEncodedFormParameterEncoder.default)
        .responseDecodable(of: KakaoTokenResponse.self) { response in
            switch response.result {
            case .success(let token):
                print("Access Token:", token.accessToken)
                print("Refresh Token:", token.refreshToken)
                
                // Keychain 저장
                KeychainService.shared.savePasswordToKeychain(
                    account: "kakaoAccessToken",
                    service: "Megabox",
                    password: token.accessToken
                )
                KeychainService.shared.savePasswordToKeychain(
                    account: "kakaoRefreshToken",
                    service: "Megabox",
                    password: token.refreshToken
                )
                
                // 사용자 정보 요청
                self.requestUserInfo(token.accessToken)
                
            case .failure(let error):
                print("토큰 요청 실패:", error)
            }
        }
    }
    
    func requestUserInfo(_ accessToken: String) {
        let url = "https://kapi.kakao.com/v2/user/me"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        AF.request(url, headers: headers)
            .responseDecodable(of: KakaoUserInfoResponse.self) { response in
                switch response.result {
                case .success(let userInfo):
                    print("사용자 ID:", userInfo.id)
                    print("닉네임:", userInfo.kakaoAccount?.profile?.nickname ?? userInfo.properties?.nickname ?? "없음")
                    print("프로필 이미지:", userInfo.kakaoAccount?.profile?.profileImageURL ?? "없음")
                    
                    // 이름(Keychain 저장)
                    let nickname = userInfo.kakaoAccount?.profile?.nickname ?? "익명"
                    KeychainService.shared.savePasswordToKeychain(
                        account: "userName",
                        service: "Megabox",
                        password: nickname
                    )
                    
                case .failure(let error):
                    print("사용자 정보 요청 실패:", error)
                }
            }
    }
}
