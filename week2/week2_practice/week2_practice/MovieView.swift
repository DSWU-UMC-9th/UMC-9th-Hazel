//
//  MovieView.swift
//  week2_practice
//
//  Created by 황민지 on 9/27/25.
//

import SwiftUI
import Observation

struct MovieView: View {
    
    @AppStorage("movieName") private var movieName: String = ""
    private var viewModel: MovieViewModel = .init()
    
    var body: some View {
        VStack(spacing : 56) {
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currnetIndex])
            
            leftRightChange
            
            settingMovie
            
            printAppStorageValue
        }
        .padding()
    }
    
    // 왼 오 change 버튼
    private var leftRightChange: some View {
        HStack {
            Group {
                makeChevron(name: "chevron.left", action: viewModel.previousMovie)
                
                Spacer()
                
                Text("영화 바꾸기")
                    .font(.system(size: 20, weight: .regular))
                
                Spacer()
                
                makeChevron(name: "chevron.right", action: viewModel.nextMovie)
            }
            .foregroundStyle(.black)
        }
        .frame(width: 256)
        .padding(.vertical, 17)
        .padding(.horizontal, 22)
    }
    
    // 화살표 재사용하기 위한 하위 뷰
    private func makeChevron(name: String, action: @escaping()-> Void)-> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: name)
                .resizable()
                .frame(width: 17.47, height: 29.73)
        })
    }
    
    // 대표 영화 설정
    private var settingMovie: some View {
        Button(action: {
            self.movieName = viewModel.movieModel[viewModel.currnetIndex].movieName
        }, label: {
            Text("대표 영화로 설정")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.black)
                .padding(.top, 21)
                .padding(.bottom, 20)
                .padding(.leading, 53)
                .padding(.trailing, 52)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .stroke(Color.black, style: .init(lineWidth: 1))
                })
        })
    }
    
    // AppStorage에 저장된 영화 출력
    private var printAppStorageValue: some View {
        VStack(spacing: 17) {
            Text("@AppStorage에 저장된 영화")
                .font(.system(size: 30, weight: .regular))
                .foregroundStyle(.black)
            Text("현재 저장된 영화 : \(movieName)")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    MovieView()
}
