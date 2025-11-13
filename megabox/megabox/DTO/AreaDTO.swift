//
//  AreaDTO.swift
//  megabox
//
//  Created by 황민지 on 11/2/25.
//

import Foundation

struct AreaDTO: Codable {
    let area: String
    let items: [ItemDTO]
}

struct AreaMapper {
    static func toDomain(from dto: AreaDTO) -> Theater {
        let halls = dto.items.map(ItemMapper.toDomain)
        return Theater(name: dto.area, halls: halls)
    }
}
