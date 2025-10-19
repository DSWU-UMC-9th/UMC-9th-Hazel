//
//  ContentView.swift
//  week4_practice
//
//  Created by 황민지 on 10/19/25.
//

import SwiftUI
import Combine

struct MovieSearchView: View {
    @StateObject private var viewModel = MovieSearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                TextField("영화명을 입력하세요.", text: $viewModel.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                if viewModel.isLoading {
                    ProgressView("검색중…")
                }

                if let error = viewModel.errorMessage {
                    Text(error).foregroundStyle(.red)
                }
                
                List(viewModel.results, id: \.id) { movie in
                    MovieCard(movie: movie)
                }
            }
            .navigationTitle("영화 검색")
        }
    }
    
    struct MovieCard: View {
        let movie: MovieModel
        
        var body: some View {
            HStack {
                movie.movieImage
                    .resizable()
                    .frame(width: 40, height: 55)
                
                VStack(alignment: .leading, spacing: 9) {
                    Text(movie.title)
                        .font(.headline)
                                            
                    Text(String(format: "%.1f", movie.rate))
                        .font(.subheadline)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
            }
        }
    }
}

#Preview {
    MovieSearchView()
}
