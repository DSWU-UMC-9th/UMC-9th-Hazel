//
//  MovieReservationModel.swift
//  megabox
//
//  Created by 황민지 on 10/12/25.
//

// movieReservationModel 정의
import Foundation
import SwiftUI

enum ScreenType: String, Codable, CaseIterable {
    case twoD = "2D"
    case threeD = "3D"
    case fourD = "4D"
    case imax = "IMAX"
}

struct Movie: Identifiable {
    let id: String  // 서버에서 받은 id
    let title: String
    let poster: Image
}

// 극장 (지점)
struct Theater: Identifiable {
    let id = UUID()
    let name: String
    let halls: [Hall]
}

// 상영관
struct Hall: Identifiable {
    let id = UUID()
    let name: String
    let totalSeatsCount: Int
    let screenType: ScreenType
}

// 상영 정보 (핵심 연결 테이블)
struct Screening: Identifiable {
    let id = UUID()
    let movie: Movie          // 어떤 영화
    let theater: Theater      // 어떤 지점
    let hall: Hall            // 어떤 상영관
    let date: Date            // 어떤 날짜
    let startTime: String     // 시작 시간
    let endTime: String       // 종료 시간
    let reservedSeatsCount: Int
}
