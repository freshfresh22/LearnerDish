//
//  PlateModel.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

// 접시 이미지 데이터

import Foundation

struct Plate: Identifiable, Codable {
    let id: Int
    let imageName: String
}

let samplePlates: [Plate] = [
    Plate(id: 0, imageName: "Plate01"),
    Plate(id: 1, imageName: "Plate02"),
    Plate(id: 2, imageName: "Plate03"),
    Plate(id: 3, imageName: "Plate04"),
    Plate(id: 4, imageName: "Plate05")
]
