//
//  TicketView.swift
//  week1_practice
//
//  Created by 황민지 on 9/18/25.
//

import SwiftUI

/// 1주차 실습: TicketView
struct TicketView: View {
    var body: some View {
        ZStack {
            Image(.background)
            
            VStack {
                Spacer().frame(height: 111)
                
                mainTitleGroup
                
                Spacer().frame(height: 134)
                
                mainBottomGroup
            }
        }
        .padding()
    }
    
    /// 상단 Title VStack
    private var mainTitleGroup: some View {
        VStack {
            Group {
                Text("마이펫의 이중생활2")
                    .font(.PretendardBold30)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                Text("본인 + 동반 1인")
                    .font(.PretendardRegular16)
                Text("30,100원")
                    .font(.PretendardBold24)
            }
            .foregroundStyle(.white)
        }
        .frame(height: 84) /// fixed -> frame에서 width, height 정적으로 지정
    }
    
    /// 하단 VStack
    private var mainBottomGroup: some View {
        Button(action: {
            print("예매하기")
        }, label: {
            VStack {
                Image(systemName: "chevron.up")
                    .resizable()
                    .frame(width: 18, height: 12)
                Text("예매하기")
                    .font(.PretendardSemiBold18)
            }
            .foregroundStyle(.white)
            .frame(width: 63, height: 40)
        })
    }
}

#Preview {
    TicketView()
}
