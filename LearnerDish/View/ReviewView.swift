//
//  Review.swift
//  LearnerDish
//
//  Created by 이시은 on 4/20/25.
//

import SwiftUI

struct ReviewView: View {
    let dishOwner: String
    let currentUser: String
    let currentHeight: CGFloat

    @StateObject private var viewModel = ReviewViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var isInputFocused: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            // ✅ 댓글 리스트
            ScrollView {
                VStack(spacing: -20) {
                    ForEach(viewModel.reviews) { review in
                        ReviewCardView(
                            review: review,
                            isMine: review.author == currentUser,
                            onDelete: {
                                if let id = review.id {
                                    viewModel.deleteReview(dishOwner: dishOwner, reviewID: id)
                                }
                            }
                        )
                        .onAppear {
                            print("🍽️ 리뷰 렌더링: \(review.author) - \(review.content)")
                        }
                    }
                }
                .padding(.bottom, 100) // 입력창이 가리지 않도록 여백
                .padding(.horizontal)
            }

            // ✅ 댓글 입력창 하단 고정
            if currentHeight > 500 {
                VStack(spacing: 0) {
                    Divider()
                    HStack {
                        TextField("리뷰 쓰기...", text: $viewModel.newReviewText)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                            .focused($isInputFocused)
                            .onChange(of: viewModel.newReviewText) { newValue in
                                print("✏️ 입력 중: \(newValue)")
                            }

                        Button(action: {
                            print("📤 [등록 버튼] 눌림")
                            viewModel.addReview(to: dishOwner, from: currentUser)
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil
                            )
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
                    .padding(.top, 10)
                    .padding(.bottom, (keyboardHeight > 0 ? keyboardHeight + 50 : 70)) //기본 높이 70, 키보드 생성시 높이 50
                    .background(Color.white)
                }
                .transition(.move(edge: .bottom))
            }
        }
        .background(Color.white)
        .presentationDetents([.fraction(0.75)])
        .onAppear {
            print("👀 ReviewView 등장! dishOwner: \(dishOwner), user: \(currentUser)")
            print("📏 currentHeight: \(currentHeight)")
            viewModel.fetchReviews(for: dishOwner)
        }
        .onDisappear {
            print("👋 ReviewView 사라짐")
            viewModel.detachListener()
            viewModel.reviews = []
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let screenHeight = UIScreen.main.bounds.height
                let keyboardTopY = keyboardFrame.origin.y
                withAnimation(.easeOut(duration: 0)) {
                    keyboardHeight = max(0, screenHeight - keyboardTopY)
                }
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

//// ReviewView.swift
//import SwiftUI
//
//struct ReviewView: View {
//    let dishID: String
//    let currentUser: String
//    let currentHeight: CGFloat
//
//    @StateObject private var viewModel = ReviewViewModel()
//    @Environment(\.dismiss) var dismiss
//    @State private var keyboardHeight: CGFloat = 0
//
//    var body: some View {
//        VStack(spacing: 0) {
//            ScrollView {
//                VStack(spacing: 0) {
//                    ForEach(viewModel.reviews) { review in
//                        ReviewCardView(review: review, isMine: review.author == currentUser)
//                    }
//                }
//                .padding()
//            }
//
//            if currentHeight > 500 {
//                Divider()
//
//                HStack {
//                    TextField("리뷰 쓰기...", text: $viewModel.newReviewText)
//                        .textFieldStyle(.roundedBorder)
//                        .padding(.horizontal)
//                        .onChange(of: viewModel.newReviewText) { newValue in
//                            print("✏️ 입력 중: \(newValue)")
//                        }
//
//                    Button(action: {
//                        print("📤 [등록 버튼] 눌림")
//                        viewModel.addReview(for: dishID, author: currentUser)
//                    }) {
//                        Text("등록")
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 8)
//                            .background(Color.red)
//                            .cornerRadius(8)
//                    }
//                    .padding(.trailing)
//                }
//                .padding(.vertical, 10)
//                .padding(.bottom, keyboardHeight + 70) // 댓글 입력창 높이
//                .transition(.move(edge: .bottom))
//            }
//        }
//        .background(Color.white)
//        .presentationDetents([.fraction(0.75)])
//        .onAppear {
//            print("👀 ReviewView 등장! dishID: \(dishID), user: \(currentUser)")
//            print("📏 currentHeight: \(currentHeight)")
//            viewModel.fetchReviews(for: dishID)
//        }
//        .onDisappear {
//            print("👋 ReviewView 사라짐")
//            viewModel.detachListener()
//        }
//        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)) { notification in
//            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//                let screenHeight = UIScreen.main.bounds.height
//                let keyboardTopY = keyboardFrame.origin.y
//
//                withAnimation(.easeOut(duration: 0.3)) {
//                    keyboardHeight = max(0, screenHeight - keyboardTopY)
//                }
//            }
//        }
//    }
//}
