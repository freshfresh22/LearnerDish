
//
//  ReviewModel.swift
//  LearnerDish
//
//  Created by 이시은 on 4/20/25.
//


import Foundation
import FirebaseFirestore


// ✅ 리뷰 데이터 모델
struct Review: Identifiable, Codable {
    @DocumentID var id: String?
    var author: String
    var content: String
    var date: Date
}

// ✅ 리뷰 뷰모델
class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var newReviewText: String = ""
    
    @Published var currentDishOwner: String = ""


    private var listener: ListenerRegistration?

//    // 리뷰 가져오기
//    func fetchReviews(for dishOwner: String) {
//        let db = Firestore.firestore()
//        listener = db.collection("reviews")
//            .document(dishOwner)
//            .collection("comments")
//            .order(by: "date")
//            .addSnapshotListener { snapshot, error in
//                guard let documents = snapshot?.documents else { return }
//                self.reviews = documents.compactMap { try? $0.data(as: Review.self) }
//            }
//    }
    
    //이거 사용
//    func fetchReviews(for dishOwner: String) {
//        detachListener()     // 기존 리스너 제거
//        self.reviews = []    // 이전 댓글 초기화
//
//        let db = Firestore.firestore()
//        listener = db.collection("reviews")
//            .document(dishOwner)
//            .collection("comments")
//            .order(by: "date")
//            .addSnapshotListener { snapshot, error in
//                guard let documents = snapshot?.documents else { return }
//                DispatchQueue.main.async {
//                    self.reviews = documents.compactMap { try? $0.data(as: Review.self) }
//                }
//            }
//    }

    func fetchReviews(for dishOwner: String) {
        // dishOwner가 다르면 리스너를 다시 붙임
        guard dishOwner != currentDishOwner else {
            print("⏩ 이미 동일한 dishOwner에 리스너가 붙어있음: \(dishOwner)")
            return
        }

        // 기존 리스너 제거하고 새로 시작
        print("🔄 리뷰 리스너 교체: \(currentDishOwner) → \(dishOwner)")
        detachListener()
        self.reviews = []
        self.currentDishOwner = dishOwner

        let db = Firestore.firestore()
        listener = db.collection("reviews")
            .document(dishOwner)
            .collection("comments")
            .order(by: "date")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                
                // ✅ 여기를 반드시 메인 쓰레드에서 실행!
                        DispatchQueue.main.async {
                            self.reviews = documents.compactMap { try? $0.data(as: Review.self) }
                            print("📦 리뷰 갱신됨: \(self.reviews.count)개")
                        }
            }
    }



    // 리뷰 추가
    func addReview(to dishOwner: String, from author: String) {
        guard !newReviewText.isEmpty else { return }

        let db = Firestore.firestore()
        let review = Review(author: author, content: newReviewText, date: Date())

        do {
            try db.collection("reviews")
                .document(dishOwner)
                .collection("comments")
                .addDocument(from: review)
            print("✅ 리뷰 저장됨")
            newReviewText = ""
        } catch {
            print("❌ 리뷰 저장 실패: \(error)")
        }
    }

    // 리뷰 삭제
    func deleteReview(dishOwner: String, reviewID: String) {
        let db = Firestore.firestore()
        db.collection("reviews")
            .document(dishOwner)
            .collection("comments")
            .document(reviewID)
            .delete { error in
                if let error = error {
                    print("❌ 댓글 삭제 실패: \(error)")
                } else {
                    print("🗑️ 댓글 삭제됨: \(reviewID)")
                }
            }
    }

    // 리스너 정리
    func detachListener() {
        listener?.remove()
    }
}



////
////  ReviewModel.swift
////  LearnerDish
////
////  Created by 이시은 on 4/20/25.
////
//
//// ReviewModel.swift
//import Foundation
//import FirebaseFirestore
//
//struct Review: Identifiable, Codable {
//    @DocumentID var id: String? //Firestore 문서 ID 자동 연동
//    //var id: String = UUID().uuidString
//    var author: String
//    var content: String
//    var date: Date
//    var likes: Int
//    var comments: Int
//}
//
//
//// ReviewViewModel.swift
//import FirebaseFirestore
//
//class ReviewViewModel: ObservableObject {
//    @Published var reviews: [Review] = []
//    @Published var newReviewText: String = ""
//
//    private var listener: ListenerRegistration?
//
//    func fetchReviews(for dishID: String) {
//        let db = Firestore.firestore()
//        listener = db.collection("reviews")
//            .document(dishID)
//            .collection("comments")
//            .order(by: "date", descending: false)
//            .addSnapshotListener { snapshot, error in
//                guard let documents = snapshot?.documents else { return }
//                self.reviews = documents.compactMap { doc in
//                    try? doc.data(as: Review.self)
//                }
//            }
//    }
//
//    func addReview(for dishID: String, author: String) {
//        let db = Firestore.firestore()
//
//        let review = Review(
//            author: author,
//            content: newReviewText,
//            date: Date(),
//            likes: 0,
//            comments: 0
//        )
//
//        print ("리뷰 생성됨 : \(review)")
//        do {
//            try db.collection("reviews")
//                .document(dishID)
//                .collection("comments")
//                .addDocument(from: review)
//            print("Firestore에 리뷰 저장 성공")
//            newReviewText = ""
//        } catch {
//            print("리뷰 저장 실패 : \(error.localizedDescription)")
//        }
//    }
//
//    func detachListener() {
//        listener?.remove()
//    }
//}
