//
//  HomeModel.swift
//  megabox
//
//  Created by 황민지 on 10/5/25.
//

// movieCard, funnyMovieCard 정의
import Foundation
import SwiftUI

/*
 무비 카드
 영화 포스터, 영화 예매, 영화 이름, 누적관객수
 */
struct movieCard: Identifiable {
    var id = UUID()
    var title: String
    var poster: Image
    var audienceCount: String
    var englishTitle: String
}

/*
 재미있는 무비
 영화 제목, 영화 포스터, 내용
 */
struct funnyMovieCard: Identifiable {
    var id = UUID()
    var title: String
    var poster: Image
    var info: String
}
