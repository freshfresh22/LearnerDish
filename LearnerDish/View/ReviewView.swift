//
//  Review.swift
//  LearnerDish
//
//  Created by 이시은 on 4/20/25.
//

// ReviewView.swift
import SwiftUI

struct ReviewView: View {
    let dishID: String
    let currentUser: String
    let currentHeight: CGFloat

    @StateObject private var viewModel = ReviewViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.reviews) { review in
                        ReviewCardView(review: review, isMine: review.author == currentUser)
                    }
                }
                .padding()
            }

            if currentHeight > 600 { // ✅ 높이 기준 조건
                Divider()
                
                HStack {
                    TextField("리뷰 쓰기...", text: $viewModel.newReviewText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.addReview(for: dishID, author: currentUser)
                    }) {
                        Text("등록")
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.trailing)
                }
                .padding(.vertical, 10)
                .transition(.move(edge: .bottom))
            }
        }
        .background(Color.white)
        .presentationDetents([.fraction(0.75)])
        .onAppear {
            viewModel.fetchReviews(for: dishID)
        }
        .onDisappear {
            viewModel.detachListener()
        }
    }
}
