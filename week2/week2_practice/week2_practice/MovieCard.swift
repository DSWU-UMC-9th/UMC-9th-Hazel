//
//  MoveCard.swift
//  week2_practice
//
//  Created by 황민지 on 9/27/25.
//

import SwiftUI

struct MovieCard: View {
    let movieInfo: MovieModel
    
    init(movieInfo: MovieModel) {
        self.movieInfo = movieInfo
    }
    
    var body: some View {
        VStack(spacing: 5) {
            movieInfo.movieImage
            
            Text(movieInfo.movieName)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.black)
            
            HStack {
                movieLike
                
                Spacer()
                
                Text("예매율 \(String(format: "%.1f", movieInfo.movieReserCount))%")
                    .font(.system(size: 9, weight: .regular))
                    .foregroundStyle(.black)
            }
        }
        // 상위 뷰 프레임 꼭 넣기
        // fixed로 고정되어 있는데 HStack 내부의 Spacer()로 뷰모 뷰의 사이즈에 영향을 받게 됨
        .frame(width: 120, height: 216)
    }
    
    // 하단 영화 좋아요
    private var movieLike: some View {
        HStack(spacing: 6) {
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .frame(width:15, height: 14)
            
            Text("\(movieInfo.movieLike)")
                .font(.system(size:9, weight: .regular))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    MovieCard(movieInfo: .init(movieImage: .init(.mickey), movieName: "미키", movieLike: 972, movieReserCount: 30.8))
}
