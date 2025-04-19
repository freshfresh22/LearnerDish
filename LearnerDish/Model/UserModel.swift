//
//  UserModel.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//


import Foundation
import SwiftUI

import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class UserModel: ObservableObject {
    static let shared = UserModel() // 👉 싱글톤 인스턴스

    // 유저 정보
    @Published var nickname: String = ""

    // 선택한 접시
    @Published var selectedPlate: Plate? = nil

    // 선택한 음식 ID들 (QuestionOption의 id)
    @Published var selectedFoods: [String] = []

    // ✅ 최종 완성된 디쉬 저장
    @Published var dishes: [DishModel] = []
    
    @Published var path: NavigationPath = NavigationPath()


    // ✅ 닉네임 저장
    func saveNicknameToFirebase() {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "nickname": self.nickname,
            "timestamp": Timestamp()
        ]

        db.collection("users").addDocument(data: data) { error in
            if let error = error {
                print("❌ 닉네임 저장 실패: \(error.localizedDescription)")
            } else {
                print("✅ 닉네임 저장 성공!")
            }
        }
    }

    func savePlateToFirebase() {
        guard let plate = selectedPlate else {
            print("❌ 접시가 선택되지 않았습니다")
            return
        }

        let db = Firestore.firestore()
        let data: [String: Any] = [
            "nickname": self.nickname,
            "selectedPlate": plate.imageName,
            "timestamp": Timestamp()
        ]

        db.collection("plates").addDocument(data: data) { error in
            if let error = error {
                print("❌ 접시 저장 실패: \(error.localizedDescription)")
            } else {
                print("✅ 접시 저장 성공!")
            }
        }
    }

    // ✅ 이미지 없이 회전값과 정보만 저장
    func saveDishMetadata(selectedOptions: [QuestionOption], rotationOffset: Double) {
        guard let plate = selectedPlate else {
            print("❌ 접시가 선택되지 않았습니다")
            return
        }

        let foodNames = selectedOptions.map { $0.foodText }
        let data: [String: Any] = [
            "nickname": self.nickname,
            "selectedPlate": plate.imageName,
            "selectedFoods": foodNames,
            "rotationOffset": rotationOffset,
            "timestamp": Timestamp()
        ]

        Firestore.firestore().collection("dishes").addDocument(data: data) { error in
            if let error = error {
                print("❌ 메타데이터 저장 실패: \(error.localizedDescription)")
            } else {
                print("✅ 디쉬 메타데이터 저장 성공!")
            }
        }
    }
}





    // ------------------------------------
    // ✅ 나중에 Firebase로 바뀔 때 예상 변경
    // ------------------------------------
    // 1. Firestore에 저장된 DishModel 데이터를 불러올 때 사용:
    //    - fetchDishesFromFirebase() -> [DishModel]
    //
    // 2. 새로운 접시를 만들었을 때 Firebase에 업로드:
    //    - uploadDishToFirebase(dish: DishModel)
    //
    // 3. image: UIImage → URL 기반 저장으로 변경 가능
    //    (Storage에 올리고 URL만 저장)
