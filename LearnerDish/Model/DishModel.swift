//
//  DishModel.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

// 완성된 디쉬 (접시+음식 조합) 정보

import Foundation
import UIKit // ✅ UIImage 사용을 위해 필요
import SwiftUI

// ✅ 앱 내 저장 및 사용용 구조체
struct DishModel: Identifiable {
    let id = UUID() // 고유 ID (Firebase에서는 String으로 저장될 예정)

    var image: UIImage // ✅ 지금은 UIImage로 저장
    var selectedOptions: [QuestionOption] = [] // 선택된 음식 정보 등

    // ⚠️ 나중에 Firebase 연결 시 아래처럼 수정될 예정:
    // 1. image → imageURL: String (Storage에 올린 이미지의 경로)
    // 2. id → String 타입 유지 (UUID().uuidString으로 생성 가능)
    // 3. QuestionOption이 Codable이면 selectedOptionIDs로 전환 가능
    
}

// ⚠️ 나중에 Firebase 저장/불러오기용 구조
//struct DishDTO: Codable {
//    var id: String
//    var imageURL: String
//    var selectedOptionIDs: [String] // QuestionOption의 ID만 저장
//}
