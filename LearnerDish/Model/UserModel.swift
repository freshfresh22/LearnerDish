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
    
    //myDishID 저장용 프로퍼티 추가
    @Published var myDishID: String? = nil
    
    @Published var isReviewVisible: Bool = false

    
    // ✅ 닉네임 저장
    func saveNicknameToFirebase() {
        let db = Firestore.firestore()
        let data: [String: Any] = [
            "nickname": self.nickname,
            "timestamp": Timestamp()
        ]
        
//        Firestore.firestore().collection("dishes").addDocument(data: data) { error in
//            if let error = error {
//                print("❌ 닉네임만 dishes에 저장 실패: \(error.localizedDescription)")
//            } else {
//                print("✅ 닉네임만 dishes에 저장 성공!")
//            }
            
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

        let db = Firestore.firestore()

        if let dishID = myDishID {
            // ✅ 기존 문서 덮어쓰기
            db.collection("dishes").document(dishID).setData(data) { error in
                if let error = error {
                    print("❌ 기존 디쉬 업데이트 실패: \(error.localizedDescription)")
                } else {
                    print("✅ 기존 디쉬 업데이트 성공!")

                    let updatedDish = DishModel(
                        id: dishID,
                        nickname: self.nickname,
                        selectedPlate: plate.imageName,
                        selectedFoods: foodNames,
                        rotation: rotationOffset,
                        imageURL: ""
                    )
                    self.dishes = [updatedDish]
                    print("✅ userModel.dishes 갱신됨")
                }
            }
        } else {
            // ✅ 새로 저장 + ID 저장
            let ref = db.collection("dishes").document()
            ref.setData(data) { error in
                if let error = error {
                    print("❌ 새 디쉬 저장 실패: \(error.localizedDescription)")
                } else {
                    self.myDishID = ref.documentID
                    UserDefaults.standard.set(ref.documentID, forKey: "myDishID")
                    print("✅ 새 디쉬 저장 + 문서 ID 저장 완료: \(ref.documentID)")

                    let newDish = DishModel(
                        id: ref.documentID,
                        nickname: self.nickname,
                        selectedPlate: plate.imageName,
                        selectedFoods: foodNames,
                        rotation: rotationOffset,
                        imageURL: ""
                    )
                    self.dishes = [newDish]
                    print("✅ userModel.dishes 갱신됨")
                }
            }
        }
    }
    
    func deleteAccountAndResetApp() {
        guard let dishID = myDishID else {
            print("❌ [deleteAccount] myDishID 없음, 삭제 취소")
            return
        }

        // 1. Firestore 삭제
        Firestore.firestore().collection("dishes").document(dishID).delete { error in
            if let error = error {
                print("❌ [deleteAccount] Firestore 삭제 실패: \(error.localizedDescription)")
            } else {
                print("✅ [deleteAccount] Firestore dish 삭제 성공")
            }
        }

        // 2. UserDefaults 초기화
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "myDishID")
        UserDefaults.standard.removeObject(forKey: "isNicknameRegistered")

        // 3. userModel 상태 초기화
        self.nickname = ""
        self.myDishID = nil
        self.selectedPlate = nil
        self.selectedFoods = []
        self.dishes = []
        self.path = NavigationPath()

        // 4. 앱 리셋 (ContentView로 루트 교체)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView())
            window.makeKeyAndVisible()
        }

        print("🧼 [deleteAccount] 계정 삭제 및 앱 초기화 완료")
    }
    func resetForEdit() {
        print("🔄 [resetForEdit] 수정 흐름용 초기화 시작")

        if let dishID = myDishID {
            deleteReviewsByNickname(nickname: self.nickname, dishID: dishID)
        }

        UserDefaults.standard.set(true, forKey: "shouldStartAtNickNameView")

        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "myDishID")
        UserDefaults.standard.removeObject(forKey: "isNicknameRegistered")

        self.nickname = ""
        self.myDishID = nil
        self.selectedPlate = nil
        self.selectedFoods = []
        self.dishes = []
        self.path = NavigationPath()

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView())
            window.makeKeyAndVisible()
        }

        print("✅ [resetForEdit] 완료 → ContentView로 전환됨")
    }


    
    func deleteReviewsByNickname(nickname: String, dishID: String) {
        let db = Firestore.firestore()
        let commentsRef = db.collection("reviews").document(dishID).collection("comments")

        commentsRef.whereField("author", isEqualTo: nickname).getDocuments { snapshot, error in
            if let error = error {
                print("❌ 댓글 불러오기 실패: \(error.localizedDescription)")
                return
            }

            for doc in snapshot?.documents ?? [] {
                doc.reference.delete()
                print("🧹 삭제된 댓글 ID: \(doc.documentID)")
            }
        }
    }


    }



//    // 업데이트 X, ✅ 기존 방식 (이미지 없이 회전값과 정보만 저장)
//    func saveDishMetadata(selectedOptions: [QuestionOption], rotationOffset: Double) {
//        guard let plate = selectedPlate else {
//            print("❌ 접시가 선택되지 않았습니다")
//            return
//        }
//
//        let foodNames = selectedOptions.map { $0.foodText }
//        let data: [String: Any] = [
//            "nickname": self.nickname,
//            "selectedPlate": plate.imageName,
//            "selectedFoods": foodNames,
//            "rotationOffset": rotationOffset,
//            "timestamp": Timestamp()
//        ]
//
//        Firestore.firestore().collection("dishes").addDocument(data: data) { error in
//            if let error = error {
//                print("❌ 메타데이터 저장 실패: \(error.localizedDescription)")
//            } else {
//                print("✅ 디쉬 메타데이터 저장 성공!")
//            }
//        }
//    }
//}




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
