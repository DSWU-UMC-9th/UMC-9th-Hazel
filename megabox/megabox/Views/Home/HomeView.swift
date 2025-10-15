//
//  HomeView.swift
//  megabox
//
//  Created by 황민지 on 10/5/25.
//

import SwiftUI

struct HomeView: View {
    
    private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    //헤더
                    HeaderGroup
                    
                    //무비카드 섹션
                    MovieCardGroup
                    
                    //재밌는 무비피드 섹션
                    FunnyMovieCardGroup
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    private var HeaderGroup: some View {
        VStack(alignment: .leading) {
            Image(.meboxLogo2)
            
            HStack(spacing: 31){
                Text("홈")
                    .foregroundStyle(.black)
                Text("이벤트")
                Text("스토어")
                Text("선호극장")
                Spacer()
            }
            .foregroundStyle(.gray04)
            .font(.semiBold24)
        }
        .padding(.leading, 16)
    }
    
    private var MovieCardGroup: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack(spacing: 23) {
                Button(action: {
                    print("무비차트 클릭")
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.gray08)
                            .frame(width: 84, height: 38)
                        Text("무비차트")
                            .font(.medium14)
                            .foregroundColor(.white)
                            .frame(alignment: .center)
                    }
                }
                Button(action: {
                    print("상영예정 클릭")
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 100)
                            .fill(.gray02)
                            .frame(width: 84, height: 38)
                        Text("상영예정")
                            .font(.medium14)
                            .foregroundColor(.gray04)
                            .frame(alignment: .center)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 18)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing:24) {
                    ForEach(viewModel.movieCard.indices, id: \.self){ index in
                        NavigationLink(
                            destination: MovieDetailView(
                                title: viewModel.movieCard[index].title,
                                englishTitle: viewModel.movieCard[index].englishTitle,
                                poster: viewModel.movieCard[index].poster
                            )
                        ) {
                            MovieCardView(movie: viewModel.movieCard[index])
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 37)
            .scrollIndicators(.hidden)
        }
    }
    
    private var FunnyMovieCardGroup: some View {
        VStack(spacing: 44){
            VStack(spacing: 4){
                HStack {
                    Text("알고보면 더 재밌는 무비피드")
                        .font(.bold24)
                        .foregroundStyle(.black)
                        .frame(alignment: .leading)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .frame(width:39, height: 39)
                }
                
                Image(.funnyMovie)
                    .resizable()
            }
            ForEach(viewModel.funnyMovieCard.indices, id: \.self){index in
                FunnyMovieCardView(funnyMovie:viewModel.funnyMovieCard[index])
            }
        }
        .padding(.horizontal, 16)
    }
    
    
}

struct MovieCardView: View {
    let movie: movieCard
    
    var body: some View {
        VStack(alignment: .leading) {
            movie.poster
                .resizable()
                .frame(width:148, height:212)
            
            Button(action: {
                print("바로예매 클릭")
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                        .stroke(.purple03, lineWidth: 1)
                        .frame(width: 148, height: 36)
                    Text("바로 예매")
                        .font(.medium16)
                        .foregroundColor(.purple03)
                        .frame(alignment: .center)
                }
            }
            
            Text(movie.title)
                .foregroundStyle(.black)
                .font(.bold22)
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(width:148, alignment: .leading)
            
            Text("누적관객수 "+movie.audienceCount)
                .font(.medium18)
                .foregroundStyle(.black)

        }
    }
}

struct FunnyMovieCardView: View {
    let funnyMovie: funnyMovieCard
    
    var body: some View {
        HStack {
            funnyMovie.poster
            
            Spacer().frame(width:23)
            
            VStack(alignment: .leading) {
                Text(funnyMovie.title)
                    .font(.semiBold18)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
                
                Text(funnyMovie.info)
                    .font(.semiBold13)
                    .foregroundStyle(.gray03)
                    .padding(.bottom, 12)
            }
        }
    }
}

#Preview {
    HomeView()
}
