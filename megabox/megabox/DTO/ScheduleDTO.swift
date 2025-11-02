//
//  ScheduleDTO.swift
//  megabox
//
//  Created by 황민지 on 11/2/25.
//

import Foundation

struct ScheduleDTO: Codable {
    let date: String
    let areas: [AreaDTO]
}

struct ScheduleMapper {
    static func toDomain(from dto: ScheduleDTO, movie: Movie) -> [Screening] {
        var screenings: [Screening] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: dto.date) else { return [] }

        for area in dto.areas {
            let theater = Theater(name: area.area, halls: [])

            for item in area.items {
                let hall = Hall(
                    name: item.auditorium,
                    totalSeatsCount: item.showtimes.first?.total ?? 0,
                    screenType: ScreenType(rawValue: item.format) ?? .twoD
                )

                for show in item.showtimes {
                    let screening = Screening(
                        movie: movie,
                        theater: theater,
                        hall: hall,
                        date: date,
                        startTime: show.start,
                        endTime: show.end,
                        reservedSeatsCount: show.total - show.available
                    )
                    screenings.append(screening)
                }
            }
        }
        return screenings
    }
}



extension DateFormatter {
    static let apiDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}
