//
//  MovieDetailView.swift
//  megabox
//
//  Created by 황민지 on 10/5/25.
//

import SwiftUI

struct MovieDetailView: View {
    
    let title: String
    let englishTitle: String
    let poster: Image
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HeaderGroup
            MovieInfoGroup
            MovieDetailGroup
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var HeaderGroup: some View {
        ZStack {
            Text(title)
                .font(.semiBold16)
            
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(.backButton)
                        .resizable()
                        .frame(width: 60, height: 60)
                })
                Spacer()
            }
        }
        
    }
    
    private var MovieInfoGroup: some View {
        VStack(spacing: 15){
            Image(.f1Poster)
            
            Text(title)
                .font(.bold24)
                .foregroundStyle(.black)
                .frame(alignment: .center)
            
            Text(englishTitle)
                .font(.semiBold14)
                .foregroundStyle(.gray03)
                .frame(alignment: .center)
            
            Text("""
                최고가 되지 못한 전설 VS 최고가 되고 싶은 루키

                한때 주목받는 유망주였지만 끔찍한 사고로 F1에서 우승하지 못하고
                한순간에 추락한 드라이버 ‘손 헤이스’(브래드 피트).
                그의 오랜 동료인 ‘루벤 세르반테스’(하비에르 바르뎀)에게
                레이싱 복귀를 제안받으며 최하위 팀인 APXGP에 합류한다.
                """)
            .font(.semiBold18)
            .padding(.horizontal, 15)
            .padding(.bottom, 35)
            .foregroundStyle(.gray03)
        }
    }
    
    private var MovieDetailGroup: some View {
        VStack{
            HStack{
                VStack{
                    Text("상세 정보")
                    Rectangle()
                        .frame(width: 220, height: 2)
                }
                
                VStack{
                    Text("실관람평")
                        .foregroundStyle(.gray02)
                    Rectangle()
                        .frame(width: 220, height: 2)
                        .foregroundStyle(.gray02)
                }
            }
            .font(.bold22)
            
            HStack(alignment: .top){
                poster
                    .resizable()
                    .frame(width: 100, height: 120)
                
                VStack(spacing: 10){
                    Text("12세 이상 관람가")
                    Text("2025.06.25 개봉")
                }
                .font(.semiBold13)
                .foregroundStyle(.black)
                
                Spacer()
            }
            .padding(15)
        }
    }
}

// 홈 탭의 무비카드 스크롤 컴포넌트에서 F1 영화 선택 시
// 영화 이름과 포스터 사진이 함께 넘어와야 함
#Preview {
    MovieDetailView(title: "F1 더 무비", englishTitle: "F1: The Movie", poster: Image(.poster3))
}
