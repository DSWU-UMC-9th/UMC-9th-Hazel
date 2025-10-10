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
    let viewModel: MovieDetailViewModel = .init()
    
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
            if let movie = viewModel.movieDetail.first(where: {$0.title == title}) {
                movie.image
                    .resizable()
                
                Text(movie.title)
                    .font(.bold24)
                    .foregroundStyle(.black)
                    .frame(alignment: .center)
                
                Text(movie.englishTitle)
                    .font(.semiBold14)
                    .foregroundStyle(.gray03)
                    .frame(alignment: .center)
                
                Text(movie.description)
                .font(.semiBold18)
                .padding(.horizontal, 15)
                .padding(.bottom, 35)
                .foregroundStyle(.gray03)
            }
        }
    }
    
    private var MovieDetailGroup: some View {
        VStack{
            HStack(spacing: 0){
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
                if let movie = viewModel.movieDetail.first(where: {$0.title == title}) {
                    movie.poster
                        .resizable()
                        .frame(width: 100, height: 120)
                    
                    VStack(spacing: 10){
                        Text(movie.age)
                        Text(movie.date + " 개봉")
                    }
                    .font(.semiBold13)
                    .foregroundStyle(.black)
                    
                    Spacer()
                }
            }
            .padding(15)
        }
    }
}

// 홈 탭의 무비카드 스크롤 컴포넌트에서 F1 영화 선택 시
// 영화 이름과 포스터 사진이 함께 넘어와야 함
#Preview {
    MovieDetailView(
        title: "F1 더 무비",
        englishTitle: "F1: The Movie",
        poster: Image(.poster3)
    )
}
