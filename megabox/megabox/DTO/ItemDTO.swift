//
//  ItemDTO.swift
//  megabox
//
//  Created by 황민지 on 11/2/25.
//

import Foundation

struct ItemDTO: Codable {
    let auditorium: String
    let format: String
    let showtimes: [ShowtimeDTO]
}

struct ItemMapper {
    static func toDomain(from dto: ItemDTO) -> Hall {
        Hall(
            name: dto.auditorium,
            totalSeatsCount: dto.showtimes.first?.total ?? 0,
            screenType: ScreenType(rawValue: dto.format) ?? .twoD
        )
    }
}
