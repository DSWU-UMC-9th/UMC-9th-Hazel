//
//  HomeViewModel.swift
//  megabox
//
//  Created by 황민지 on 10/5/25.
//

import Foundation
import SwiftUI

@Observable
class HomeViewModel {
    let movieCard: [movieCard] = [
        .init(title: "어쩔수가없다", poster: Image("poster1"), audienceCount: "10만", englishTitle: "No Way Out"),
        .init(title: "극장판 귀멸의 칼날 : 무한성편", poster: Image("poster2"), audienceCount: "20만", englishTitle: "Demon Slayer: Kimetsu no Yaiba – Infinity Castle"),
        .init(title: "F1 더 무비", poster: Image("poster3"), audienceCount: "30만", englishTitle: "F1: The Movie"),
        .init(title: "얼굴", poster: Image("poster4"), audienceCount: "40만", englishTitle: "The Face"),
        .init(title: "모노노케 히메", poster: Image("poster5"), audienceCount: "50만", englishTitle: "Princess Mononoke")
    ]
    
    let funnyMovieCard: [funnyMovieCard] = [
        .init(title: "9월, 메가박스의 영화들(1) - 명작의 재개봉", poster: .init(.funnyMoivePoster1), info: "<모노노케 히메>, <퍼펙트 블루>"),
        .init(title: "매가박스 오리지널 티켓 Re.37 <얼굴>", poster: .init(.funnyMoviePoster2), info: "영화 속 양극적인 감정의 대비")
    ]
}
