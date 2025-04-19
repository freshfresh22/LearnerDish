//
//  DishModel.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

// 완성된 디쉬 (접시+음식 조합) 정보

// DishModel.swift

//
//  DishModel.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

import Foundation
import FirebaseFirestore

struct DishModel: Identifiable, Codable {
    @DocumentID var id: String?
    let nickname: String
    let selectedPlate: String
    let selectedFoods: [String]
    let rotation: Double // ✅ 뷰에서 계속 쓰던 이름 유지
    var isLeftAligned: Bool = true
    let imageURL: String? // <- 이거!



    // 🔄 Firestore 필드명이 "rotationOffset"이므로 매핑!
    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case selectedPlate
        case selectedFoods
        case rotation = "rotationOffset"
        case imageURL
    }
}
