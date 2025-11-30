//
//  UserInfoManagementView.swift
//  megabox
//
//  Created by 황민지 on 9/27/25.
//

import SwiftUI

struct UserInfoManagementView: View {
    let loginType: LoginType?
    @Binding var userName: String
    @Environment(\.dismiss) var dismiss
    
    private var userId: String {
        switch loginType {
        case .local(let id):
            return id
        case .kakao(let id):
            return id
        default:
            return "익명"
        }
    }
    
    var body: some View {
        VStack {
            Header
            Spacer().frame(height: 53)
            BasicInfoGroup
            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationBarBackButtonHidden()
    }
    
    // 맨 위 헤더
    var Header: some View {
        HStack {
            Button (action: {
                print("뒤로 가기")
                dismiss()
            }) {
                Image(.leading)
                    .foregroundStyle(.black)
                    .frame(width: 26, height: 22)
            }
            
            Spacer()
            
            Text("회원정보 관리")
                .font(.medium16)
                .foregroundStyle(.black)
            
            Spacer()
        }
    }
    
    var BasicInfoGroup: some View {
        VStack(alignment: .leading, spacing: 26) {
            Text("기본정보")
                .font(.bold18)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("\(userId)")
                        .font(.medium18)
                        .foregroundStyle(Color.black)
                    Divider()
                        .background(.gray02)
                }
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        TextField("회원 이름", text: $userName)
                            .font(.medium18)
                            .foregroundStyle(Color.black)
                        
                        Spacer()
                        
                        Button {
                            saveUserNameToKeychain()
                        } label: {
                            Text("변경")
                                .font(.medium10)
                                .foregroundStyle(.gray03)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.gray03, lineWidth: 1)
                                }
                        }
                    }
                    
                    Divider()
                        .background(.gray02)
                }
            }
        }
    }
    
    // 이름 변경 -> 저장 함수
    private func saveUserNameToKeychain() {
        switch loginType {
        case .local(let id):
            KeychainService.shared.savePasswordToKeychain(
                account: "userName_\(id)",
                service: "Megabox",
                password: userName
            )

        case .kakao:
            KeychainService.shared.savePasswordToKeychain(
                account: "userName_kakao",
                service: "Megabox",
                password: userName
            )

        default:
            break
        }

        print("이름 저장 완료:", userName)
    }
}

#Preview {
    UserInfoManagementView(
        loginType: .local(id: "test123"),
        userName: .constant("익명")
    )
}
