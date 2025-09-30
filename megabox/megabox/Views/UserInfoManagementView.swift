//
//  UserInfoManagementView.swift
//  megabox
//
//  Created by 황민지 on 9/27/25.
//

import SwiftUI

struct UserInfoManagementView: View {
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("id") private var id: String = ""
    @State private var viewModel_login: LoginViewModel = .init()
    @State private var viewModel_info: UserInfoViewModel = .init()

    var body: some View {
        VStack {
            Header
            Spacer().frame(height: 53)
            BasicInfoGroup
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    // 맨 위 헤더
    var Header: some View {
        HStack {
            Button (action: {
                print("뒤로 가기")
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
                    Text("\(id)")
                        .font(.medium18)
                        .foregroundStyle(Color.black)
                    Divider()
                        .background(.gray02)
                }
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        TextField("회원 이름", text: $viewModel_info.userInfoModel.userName)
                            .font(.medium18)
                            .foregroundStyle(Color.black)
                        
                        Spacer()
                        
                        Button {
                            self.userName = viewModel_info.userInfoModel.userName
                            print("\(id), \(userName)")
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
}

#Preview {
    UserInfoManagementView()
}
