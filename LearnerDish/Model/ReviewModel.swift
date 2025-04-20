//
//  ReviewModel.swift
//  LearnerDish
//
//  Created by 이시은 on 4/20/25.
//

// ReviewModel.swift
import Foundation

struct Review: Identifiable, Codable {
    var id: String = UUID().uuidString
    var author: String
    var content: String
    var date: Date
    var likes: Int
    var comments: Int
}


// ReviewViewModel.swift
import FirebaseFirestore

class ReviewViewModel: ObservableObject {
    @Published var reviews: [Review] = []
    @Published var newReviewText: String = ""

    private var listener: ListenerRegistration?

    func fetchReviews(for dishID: String) {
        let db = Firestore.firestore()
        listener = db.collection("reviews")
            .document(dishID)
            .collection("comments")
            .order(by: "date", descending: false)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.reviews = documents.compactMap { doc in
                    try? doc.data(as: Review.self)
                }
            }
    }

    func addReview(for dishID: String, author: String) {
        let db = Firestore.firestore()
        let review = Review(
            author: author,
            content: newReviewText,
            date: Date(),
            likes: 0,
            comments: 0
        )
        do {
            try db.collection("reviews")
                .document(dishID)
                .collection("comments")
                .addDocument(from: review)
            newReviewText = ""
        } catch {
            print("Error writing review: \(error)")
        }
    }

    func detachListener() {
        listener?.remove()
    }
}
