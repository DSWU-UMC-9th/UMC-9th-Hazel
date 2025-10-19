//
//  ContentView.swift
//  week4_practice
//
//  Created by 황민지 on 10/19/25.
//

import Foundation
import SwiftUI

struct MovieModel: Identifiable {
    let id: UUID = .init()
    let movieImage: Image
    let title: String
    let rate: Double
}
