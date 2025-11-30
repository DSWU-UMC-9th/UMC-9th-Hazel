//
//  LoginViewModel.swift
//  megabox
//
//  Created by 황민지 on 9/27/25.
//

import Foundation
import KakaoSDKUser

class LoginViewModel: ObservableObject {

    @Published var isLoginSuccess: Bool = false
    @Published var loginModel: LoginModel = .init()
    @Published var loginType: LoginType?

    let keychain = KeychainService.shared
    let service = "Megabox"

    // MARK: - 일반 로그인
    func userLogin() {
        guard let savedId = keychain.load(account: "userId", service: service),
              let savedPwd = keychain.load(account: "userPwd", service: service) else {
            print("저장된 계정 없음")
            return
        }

        if loginModel.id == savedId && loginModel.pwd == savedPwd {
            print("일반 로그인 성공")

            // 로그인 타입 저장
            loginType = .local(id: savedId)

            // userName_아이디 불러오기
            let nameKey = "userName_\(savedId)"
            if keychain.load(account: nameKey, service: service) == nil {
                // 없으면 기본값 저장
                keychain.savePasswordToKeychain(
                    account: nameKey,
                    service: service,
                    password: "익명"
                )
            }

            DispatchQueue.main.async {
                self.isLoginSuccess = true
            }
        } else {
            print("일반 로그인 실패")
        }
    }

    // MARK: - 회원가입
    func userSignup() {
        guard !loginModel.id.isEmpty,
              !loginModel.pwd.isEmpty else {
            print("빈칸 있음")
            return
        }

        // 계정 저장
        keychain.savePasswordToKeychain(account: "userId", service: service, password: loginModel.id)
        keychain.savePasswordToKeychain(account: "userPwd", service: service, password: loginModel.pwd)

        // 이름은 userName_아이디로 저장
        keychain.savePasswordToKeychain(
            account: "userName_\(loginModel.id)",
            service: service,
            password: "익명"
        )

        print("회원가입 완료")
    }

    // MARK: - 카카오 로그인
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoAccount()
        }
    }

    private func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
            if let error = error {
                print("카톡 로그인 실패:", error)
            } else {
                print("카톡 로그인 성공")

                // accessToken 키체인 저장
                if let token = oauthToken?.accessToken {
                    self.keychain.savePasswordToKeychain(
                        account: "kakaoAccessToken",
                        service: self.service,
                        password: token
                    )
                    print("카카오 accessToken 저장 완료:", token)
                }

                self.fetchKakaoUserInfo()
            }
        }
    }

    private func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
            if let error = error {
                print("계정 로그인 실패:", error)
            } else {
                print("계정 로그인 성공")

                // accessToken 키체인 저장
                if let token = oauthToken?.accessToken {
                    self.keychain.savePasswordToKeychain(
                        account: "kakaoAccessToken",
                        service: self.service,
                        password: token
                    )
                    print("카카오 accessToken 저장 완료:", token)
                }

                self.fetchKakaoUserInfo()
            }
        }
    }
    
    // MARK: - 카카오 사용자 정보 가져오기
    private func fetchKakaoUserInfo() {
        UserApi.shared.me { user, error in
            if let error = error {
                print("카카오 사용자 정보 실패: \(error)")
            } else if let user = user {

                let kakaoId = String(user.id ?? 0)
                let nickname = user.kakaoAccount?.profile?.nickname ?? "카카오유저"

                // 로그인 타입 저장
                self.loginType = .kakao(id: kakaoId)

                // userName_kakao 저장
                self.keychain.savePasswordToKeychain(
                    account: "userName_kakao",
                    service: self.service,
                    password: nickname
                )

                print("카카오 닉네임 저장됨:", nickname)

                DispatchQueue.main.async {
                    self.isLoginSuccess = true
                }
            }
        }
    }
}

