//
//  LoginView.swift
//  megabox
//
//  Created by 황민지 on 9/18/25.
//

import SwiftUI
import Observation

struct LoginView: View {
    @State private var viewModel: LoginViewModel = .init()
    @State private var isLoginSuccess: Bool = false
    @State private var showErrorAlert: Bool = false
    
    let keychain = KeychainService.shared
    let account = "userId"
    let service = "Megabox"
    let password = "userPassword"
    let userName = "익명"
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 44)
                TitleTextGroup
                Spacer() // 자동
                TextFieldGroup
                Spacer().frame(height: 75)
                ButtonGroup
                Spacer().frame(height: 35)
                SocialLoginButtonGroup
                Spacer().frame(height: 39)
                UMCGroup
                Spacer().frame(height: 91)
            }
            .padding(.horizontal, 16)
            .navigationDestination(isPresented: $isLoginSuccess) {TabBar()}
            .onAppear {
                autoLoginIfPossible()
            }
        }
    }
    
    // 맨 위 로그인 제목
    private var TitleTextGroup: some View {
        Text("로그인")
            .font(.semiBold24)
            .foregroundStyle(.black)
    }
    
    // 로그인, 비밀번호 입력칸
    private var TextFieldGroup: some View {
        VStack(spacing: 40) {
            VStack(spacing: 4) {
                TextField("아이디", text: $viewModel.loginModel.id)
                    .font(.medium16)
                    .foregroundStyle(.gray03)
                Divider()
                    .background(.gray02)
            }
            VStack(spacing: 4) {
                SecureField("비밀번호", text: $viewModel.loginModel.pwd)
                    .font(.medium16)
                    .foregroundStyle(.gray03)
                Divider()
                    .background(.gray02)
            }
        }
    }
    
    // 버튼(로그인, 회원가입)
    private var ButtonGroup: some View {
        VStack(spacing: 17) {
            Button(action: {
                userLogin()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.purple03)
                        .frame(height: 54)
                    Text("로그인")
                        .font(.bold18)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                }
            }
            
            Button(action: {
                userSignup()
            }) {
                Text("회원가입")
                    .font(.medium13)
                    .foregroundStyle(.gray04)
            }
        }
    }
    
    // 유저 로그인 로직
    private func userLogin() {
        guard let savedId = keychain.load(account: "userId", service: service),
              let savedPwd = keychain.load(account: "userPwd", service: service) else {
            print("Keychain에 저장된 정보 없음")
            showErrorAlert = true
            return
        }
        
        let inputId = viewModel.loginModel.id
        let inputPwd = viewModel.loginModel.pwd
        
        if inputId == savedId && inputPwd == savedPwd {
            print("로그인 성공")
            isLoginSuccess = true
        } else {
            print("로그인 실패")
            showErrorAlert = true
        }
    }
    
    // 유저 회원가입 로직
    private func userSignup() {
        let id = viewModel.loginModel.id
        let pwd = viewModel.loginModel.pwd
        
        guard !id.isEmpty, !pwd.isEmpty else {
            print("입력 누락")
            return
        }
        
        // Keychain에 각각 저장되게
        keychain.savePasswordToKeychain(account: "userId", service: service, password: id)
        keychain.savePasswordToKeychain(account: "userPwd", service: service, password: pwd)
        keychain.savePasswordToKeychain(account: "userName", service: service, password: userName)
        
        print("회원가입 완료 — Keychain에 \(id), \(pwd), \(userName) 저장됨")
    }
    
    // 자동 로그인
    private func autoLoginIfPossible() {
        if let _ = keychain.load(account: "userId", service: service),
           let _ = keychain.load(account: "userPwd", service: service) {
            print("자동 로그인 성공")
            isLoginSuccess = true
        } else {
            print("자동 로그인 정보 없음")
        }
    }
    
    // 소셜 로그인 버튼
    private var SocialLoginButtonGroup: some View {
        HStack(spacing: 73) {
            Button(action: {
                print("네이버 로그인")
            }) {
                Image(.naverLoginButton)
            }
            Button(action: {
                print("카카오 로그인")
            }) {
                Image(.kakaoLoginButton)
            }
            Button(action: {
                print("애플 로그인")
            }) {
                Image(.appleLoginButton)
            }
        }
    }
    
    // 맨 아래 UMC 홍보 그림
    private var UMCGroup: some View {
        Image(.umc)
            .resizable()
            .frame(maxWidth: .infinity)
            .aspectRatio(contentMode: .fit)
    }
    
}

#Preview {
    LoginView()
}
