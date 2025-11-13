//
//  ShowtimeDTO.swift
//  megabox
//
//  Created by 황민지 on 11/2/25.
//

import Foundation

struct ShowtimeDTO: Codable {
    let start: String
    let end: String
    let available: Int
    let total: Int
}
