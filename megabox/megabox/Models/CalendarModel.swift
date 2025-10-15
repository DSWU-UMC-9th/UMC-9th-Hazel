//
//  CalendarModel.swift
//  megabox
//
//  Created by 황민지 on 10/13/25.
//

import Foundation
import SwiftUI

struct CalendarDay: Identifiable {
    var id: UUID = .init()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
}
