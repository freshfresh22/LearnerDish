//
//  UserModel.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
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
import FirebaseStorage

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

        Firestore.firestore().collection("dishes").addDocument(data: data) { error in
                if let error = error {
                    print("❌ 닉네임만 dishes에 저장 실패: \(error.localizedDescription)")
                } else {
                    print("✅ 닉네임만 dishes에 저장 성공!")
                }
            
//        db.collection("users").addDocument(data: data) { error in
//            if let error = error {
//                print("❌ 닉네임 저장 실패: \(error.localizedDescription)")
//            } else {
//                print("✅ 닉네임 저장 성공!")
//            }
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

//    // ✅ 디쉬 이미지와 메타데이터 저장
//    @MainActor
//    func saveDishWithImage(selectedOptions: [QuestionOption], rotationOffset: Double, renderedView: RenderedDishView) {
//        guard let plate = selectedPlate else {
//            print("❌ 접시가 선택되지 않았습니다")
//            return
//        }
//
//        // 1. 렌더링
//        let renderer = ImageRenderer(content: renderedView)
//        guard let uiImage = renderer.uiImage else {
//            print("❌ 이미지 렌더링 실패")
//            return
//        }
//        print("✅ 이미지 렌더링 성공")
//
//        // 2. 이미지 PNG로 변환
//        guard let imageData = uiImage.pngData() else {
//            print("❌ PNG 변환 실패")
//            return
//        }
//        print("✅ PNG 데이터 생성 성공")
//
//        // 3. Storage에 업로드
//        let filename = UUID().uuidString + ".png"
//        let storageRef = Storage.storage().reference().child("dishes/\(filename)")
//        print("📤 Storage 업로드 시작")
//
//        storageRef.putData(imageData, metadata: nil) { metadata, error in
//            if let error = error {
//                print("❌ Storage 업로드 실패: \(error.localizedDescription)")
//                return
//            }
//            print("✅ Storage 업로드 성공")
//
//            // 4. 다운로드 URL 요청
//            storageRef.downloadURL { url, error in
//                if let error = error {
//                    print("❌ 다운로드 URL 획득 실패: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let downloadURL = url else {
//                    print("❌ 다운로드 URL 없음")
//                    return
//                }
//
//                print("🌐 다운로드 URL 획득 성공: \(downloadURL.absoluteString)")
//
//                // 5. Firestore에 메타데이터 저장
//                let foodNames = selectedOptions.map { $0.foodText }
//                let data: [String: Any] = [
//                    "nickname": self.nickname,
//                    "selectedPlate": plate.imageName,
//                    "selectedFoods": foodNames,
//                    "rotationOffset": rotationOffset,
//                    "imageURL": downloadURL.absoluteString,
//                    "timestamp": Timestamp()
//                ]
//
//                Firestore.firestore().collection("dishes").addDocument(data: data) { error in
//                    if let error = error {
//                        print("❌ 메타데이터 저장 실패: \(error.localizedDescription)")
//                    } else {
//                        print("✅ 디쉬 이미지 + 메타데이터 저장 Firestore 성공!")
//                    }
//                }
//            }
//        }
//    }


    // ✅ 기존 방식 (이미지 없이 회전값과 정보만 저장)
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
    //    (Storage에 올리고 URL만 저장) 이거에 맞게 각 파일 수정
