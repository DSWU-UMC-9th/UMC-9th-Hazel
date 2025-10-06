//
//  LoginView.swift
//  megabox
//
//  Created by 황민지 on 9/18/25.
//

import SwiftUI
import Observation

struct LoginView: View {
    @AppStorage("id") private var id: String = ""
    @AppStorage("pwd") private var pwd: String = ""
    @AppStorage("userName") private var userName: String = ""
    @State private var viewModel: LoginViewModel = .init()
    @State private var viewModel_info: UserInfoViewModel = .init()
    @State private var isLoginSuccess: Bool = false
    @State private var showErrorAlert: Bool = false
    
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
            .navigationDestination(isPresented: $isLoginSuccess) {HomeView()}
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
                print("로그인")
                let inputId = viewModel.loginModel.id
                let inputPwd = viewModel.loginModel.pwd
                print("입력 : \(inputId) \(inputPwd)")
                
                print("원래꺼 \(id)")
                
                if inputId == id && inputPwd == pwd && !pwd.isEmpty {
                    print("로그인 성공")
                    isLoginSuccess = true
                } else {
                    print("로그인 실패")
                    showErrorAlert = true
                }
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
                id = viewModel.loginModel.id
                pwd = viewModel.loginModel.pwd
                print("회원가입 완료 — \(id), \(pwd) 저장됨")
                self.userName = "임의"
            }) {
                Text("회원가입")
                    .font(.medium13)
                    .foregroundStyle(.gray04)
            }
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
