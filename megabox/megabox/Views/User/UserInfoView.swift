//
//  UserInfoView.swift
//  megabox
//
//  Created by 황민지 on 9/27/25.
//

import SwiftUI

struct UserInfoView: View {
    let loginType: LoginType?

    @State private var userName: String = "익명"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 33) {
                VStack(spacing: 15) {
                    ProfileHeader
                    ClubMemberShip
                }
                StatusInformation
                ButtonGroup
                Spacer()
            }
            .padding(.top, 60)
            .padding(.horizontal, 16)
            .onAppear {
                loadUserName()
            }
        }
    }
    
    private func loadUserName() {
        switch loginType {
        case .local(let id):
            userName = KeychainService.shared.load(
                account: "userName_\(id)",
                service: "Megabox"
            ) ?? "익명"

        case .kakao:
            userName = KeychainService.shared.load(
                account: "userName_kakao",
                service: "Megabox"
            ) ?? "익명"

        case .none:
            userName = "익명"
        }
    }
    
    private var ProfileHeader: some View {
        VStack {
            HStack {
                let name = userName.trimmingCharacters(in: .whitespacesAndNewlines)

                Text("\(String(userName.prefix(1)))" + "*" + "\(name.suffix(1))")
                    .font(.bold24)
                    .foregroundStyle(.black)
                
                Text("WELCOME")
                    .font(.medium14)
                    .foregroundStyle(.white)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.tag)
                    }
                
                Spacer()
                
                NavigationLink(destination: UserInfoManagementView(loginType: loginType, userName: $userName)){
                    Text("회원정보")
                        .font(.semiBold14)
                        .foregroundStyle(.white)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 11.5)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray07)
                    }
                }
            }
            
            HStack(spacing: 9) {
                Text("멤버쉽 포인트")
                    .font(.semiBold14)
                    .foregroundStyle(.gray04)
                
                Text("999P")
                    .font(.medium14)
                    .foregroundStyle(.black)
                
                Spacer()
            }
        }
    }
    
    private var ClubMemberShip: some View {
        Button(action: {
            print("클럽 멤버쉽 버튼 클릭")
        }) {
            HStack {
                Text("클럽 멤버십")
                    .foregroundStyle(.white)
                    .font(.semiBold16)
                Image(systemName: "chevron.right")
                    .foregroundStyle(.white)
                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 8)
            .background(
                LinearGradient(
                    colors: [.linearGradient1, .linearGradient2, .linearGradient3],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(8)
        }
    }
    
    private var StatusInformation: some View {
        HStack(spacing:0) {
            
            makeStatus(title: "쿠폰", count: 2)
            
            Divider()
                .foregroundStyle(.gray03)
                .frame(width: 1, height: 31)
            
            makeStatus(title: "스토어 교환권", count: 0)
            
            Divider()
                .foregroundStyle(.gray03)
                .frame(width: 1, height: 31)
            
            makeStatus(title: "모바일 티켓", count: 0)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray02, lineWidth: 1)
        }
        
    }
    
    private func makeStatus(title: String, count: Int) -> some View {
        VStack(spacing: 8){
            Text(title)
                .font(.semiBold16)
                .foregroundStyle(.gray02)
                .fixedSize()
            
            Text(String(count))
                .font(.semiBold18)
                .foregroundStyle(.black)
                .fixedSize()
        }
        .frame(maxWidth: .infinity)
    }
    
    private var ButtonGroup: some View {
        HStack {
            ReservationButton(image: "film-reel", text: "영화별 예매")
            
            Spacer()
            
            ReservationButton(image: "pin-map", text: "극장별 예매")
            
            Spacer()
            
            ReservationButton(image: "sofa", text: "특별관 예매")
            
            Spacer()
            
            ReservationButton(image: "cinema", text: "모바일오더")
        }
    }
    
    private struct ReservationButton: View {
        var image: String
        var text: String
        
        var body: some View {
            Button(action: {
                print("예매 버튼 클릭")
            }) {
                VStack {
                    Image(image)
                        .resizable()
                        .frame(width: 36, height: 36)
                    
                    Text(text)
                        .font(.medium16)
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    UserInfoView(loginType: .local(id: "test"))
}
