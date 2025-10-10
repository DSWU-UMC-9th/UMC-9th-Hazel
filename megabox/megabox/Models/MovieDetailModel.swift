//
//  MovieDetailModel.swift
//  megabox
//
//  Created by 황민지 on 10/10/25.
//

// movieDetailModel 정의
import Foundation
import SwiftUI

struct MovieDetailModel: Identifiable {
    var id = UUID()
    var poster: Image
    var image: Image
    var title: String
    var englishTitle: String
    var description: String
    var age: String
    var date: String
}
