//
//  FireStoreManager.swift
//  LearnerDish
//
//  Created by 이시은 on 4/19/25.
//

// FirestoreManager.swift

import Foundation
import FirebaseFirestore

class FirestoreManager: ObservableObject {
    @Published var dishes: [DishModel] = []

    private let db = Firestore.firestore()

    // ✅ 외부에서 완료 시점 알 수 있도록 completion 핸들러 추가
    func fetchDishes(completion: @escaping () -> Void = {}) {
        db.collection("dishes").getDocuments { snapshot, error in
            if let error = error {
                print("❌ Firestore 에러: \(error.localizedDescription)")
                completion()
                return
            }

            guard let documents = snapshot?.documents else {
                print("📭 문서 없음")
                completion()
                return
            }

            self.dishes = documents.compactMap { doc in
                do {
                    let dish = try doc.data(as: DishModel.self)
                    print("✅ 불러온 Dish: \(dish)")
                    return dish
                } catch {
                    print("⚠️ 디코딩 실패: \(error)")
                    return nil
                }
            }

            // ✅ 불러온 후 콜백 호출
            completion()
        }
    }
}
