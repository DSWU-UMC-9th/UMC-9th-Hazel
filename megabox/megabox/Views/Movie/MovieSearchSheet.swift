//
//  MovieSearchView.swift
//  megabox
//
//  Created by 황민지 on 10/12/25.
//

import SwiftUI
import Combine

struct MovieSearchSheet: View {
    @ObservedObject var viewModel: MovieReservationViewModel
    var onSelect: (Movie) -> Void
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 0){
                Text("영화 선택")
                    .font(.semiBold18)
                    .padding(.top, 16)
                    .padding(.bottom, 36)
                
                
                if viewModel.isLoading && viewModel.results.isEmpty {
                    ProgressView("검색중…")
                        .frame(maxHeight: .infinity)
                }

                if let error = viewModel.errorMessage {
                    Text(error).foregroundStyle(.red)
                }
                
                let columns: [GridItem] = Array(
                    repeating: GridItem(.flexible(), alignment: .top),
                    count: 3
                )
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: 36) {
                    if viewModel.query.isEmpty { // 검색어 없을 때 -> 전체 영화 목록 조회
                        ForEach(viewModel.movies) { movie in
                            Button {
                                onSelect(movie)
                            } label: {
                                MovieCard(movie: movie)
                            }
                        }
                        .padding(.horizontal, 16)
                    } else {
                        // 검색어 있을 때 -> 검색 결과에 맞는 영화 목록 조회
                        ForEach(viewModel.results) { movie in
                            Button {
                                onSelect(movie)
                            } label: {
                                MovieCard(movie: movie)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
                
                Spacer()
                
                TextField("영화명을 입력해주세요", text: $viewModel.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
            }
        }
        .foregroundStyle(.black)
        .ignoresSafeArea(edges: .top)
        .navigationTitle("영화 선택")
    }
    
    //MARK: - 영화 카드
    struct MovieCard: View {
        let movie: Movie
        
        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                movie.poster
                    .resizable()
                    .frame(width: 95, height: 135)
                    .padding(.bottom, 8)
                Text("\(movie.title)")
                    .font(.semiBold14)
            }
        }
    }
}

#Preview {
    MovieSearchSheet(viewModel: MovieReservationViewModel()) { _ in }
}
