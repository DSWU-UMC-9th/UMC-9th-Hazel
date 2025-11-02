//
//  MovieDTO.swift
//  megabox
//
//  Created by 황민지 on 11/2/25.
//

import Foundation
import SwiftUI

struct MovieDTO: Codable {
    let id: String
    let title: String
    let ageRating: String
    let poster: String
    let schedules: [ScheduleDTO]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case ageRating = "age_rating"
        case poster = "poster"
        case schedules
    }
}

struct MovieMapper {
    static func toDomain(from dto: MovieDTO) -> Movie {
//        let imageResource: ImageResource
//
//        switch dto.poster {
//        case "poster1": imageResource = .poster1
//        case "poster2": imageResource = .poster2
//        case "poster3": imageResource = .poster3
//        case "poster4": imageResource = .poster4
//        case "poster5": imageResource = .poster5
//        case "poster6": imageResource = .poster6
//        case "poster7": imageResource = .poster7
//        case "poster8": imageResource = .poster8
//        default:
//            imageResource = .poster1
//        }

        return Movie(
            id: dto.id,
            title: dto.title,
            poster: Image(dto.poster)
        )
    }
    
    static func toScreenings(from dto: MovieDTO) -> [Screening] {
        let movie = toDomain(from: dto)
        return dto.schedules.flatMap { ScheduleMapper.toDomain(from: $0, movie: movie) }
    }
}
