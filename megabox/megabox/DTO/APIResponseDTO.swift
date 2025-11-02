//
//  APIResponseDTO.swift
//  megabox
//
//  Created by 황민지 on 11/2/25.
//

import Foundation

struct APIResponseDTO: Codable {
    let status: String
    let message: String
    let data: ShowtimesDataDTO
}
