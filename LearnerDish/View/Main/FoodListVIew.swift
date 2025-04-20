//
//  FoodListVIew.swift
//  LearnerDish
//
//  Created by 이시은 on 4/17/25.
//

import SwiftUI

struct FoodListView: View {
    @Binding var isPresented: Bool
    @State private var currentPage = 0

    // 예시 데이터 (총 3페이지라고 가정)
    let foodPages: [[(image: String, name: String, desc: String)]] = [
        [("능이백숙", "능이백숙", "조용히 알아가는 타입"), ("마라탕", "마라탕", "조용히 알아가는 타입")],
        [("능이백숙", "능이백숙", "조용히 알아가는 타입"), ("마라탕", "마라탕", "조용히 알아가는 타입")],
        [("능이백숙", "능이백숙", "조용히 알아가는 타입"), ("마라탕", "마라탕", "조용히 알아가는 타입")]
    ]

    var body: some View {
        ZStack {
            // 배경 클릭 시 닫힘
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }

            // 메인 카드
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    Image("FoodIcon") // 웃는 요리사 이미지로 대체해도 좋아
                        .resizable()
                        .frame(width: 40, height: 40)

                    Text("Food List")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.red)
                }

                TabView(selection: $currentPage) {
                    ForEach(foodPages.indices, id: \.self) { index in
                        VStack(spacing: 15) {
                            ForEach(foodPages[index], id: \.name) { food in
                                VStack(spacing: 4) {
                                    Image(food.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                    Text(food.name)
                                        .font(.headline)
                                    Text(food.desc)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // 인디케이터 수동으로 만들거라 숨김
                .frame(height: 300)

                // 페이지 인디케이터
                HStack(spacing: 8) {
                    ForEach(0..<foodPages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.black : Color.gray.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 10)
            }
            .padding()
            .frame(width: 320, height: 600)
            .background(Color.white)
            .cornerRadius(24)
            .shadow(radius: 10)
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
    }
}

#Preview {
    FoodListView(isPresented: .constant(true))
}
