//
//  UserInfoView.swift
//  megabox
//
//  Created by 황민지 on 9/27/25.
//

import SwiftUI

struct UserInfoView: View {
    @AppStorage("userName") private var userName: String = ""
    @State private var viewModel_info: UserInfoViewModel = .init()
    
    var body: some View {
        VStack {
            Spacer().frame(height: 103)
            ProfileHeader
            Spacer().frame(height: 15)
            ClubMemberShip
            Spacer().frame(height: 33)
            StatusInformation
            Spacer().frame(height: 33)
            ButtonGroup
            Spacer()
        }
        .padding(.horizontal, 14)
    }
    
    private var ProfileHeader: some View {
        VStack {
            HStack {
                Text("\(userName.first!)*\(userName.last!)님")
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
                
                Button(action: {
                    print("회원정보 버튼 클릭")
                }) {
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
            Status(text: "쿠폰", value: "2")
            
            Divider()
                .padding(.horizontal, 43)
            
            Status(text: "스토어 교환권", value: "0")
            
            Divider()
                .padding(.horizontal, 43)
            
            Status(text: "모바일 티켓", value: "0")
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray02, lineWidth: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: 76)
    }
    
    private struct Status: View {
        var text: String
        var value: String
        
        var body: some View {
            VStack(spacing: 9){
                Text(text)
                    .font(.semiBold16)
                    .foregroundStyle(.gray02)
                    .fixedSize()
                    
                
                Text(value)
                    .font(.semiBold18)
                    .foregroundStyle(.black)
            }
        }
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
    UserInfoView()
}
