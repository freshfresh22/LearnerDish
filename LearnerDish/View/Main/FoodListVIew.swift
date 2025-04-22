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
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 72)
                        .offset(y:11)

                    Text("Food List")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.red)
                        .offset(y:5)
                }

                TabView(selection: $currentPage) {

                    VStack(spacing: 10) { //1쪽
                        HStack(spacing: 5) { //1열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist01")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist01")
                        }
                        HStack(spacing: 5) { //2열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist02")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist02")
                        }
                        HStack(spacing: 5) { //3열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist04")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist04")
                        }
                    }
                    .tag(0)
                    
                    VStack(spacing: 10) { //1쪽
                        HStack(spacing: 5) { //1열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist04")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist04")
                        }
                        HStack(spacing: 5) { //2열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist03")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist03")
                        }
                        HStack(spacing: 5) { //3열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist05")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist05")
                        }
                    }
                    .tag(1)
                    
                    VStack(spacing: 10) { //1쪽
                        HStack(spacing: 5) { //1열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist02")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist02")
                        }
                        HStack(spacing: 5) { //2열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist04")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist04")
                        }
                        HStack(spacing: 5) { //3열
                            foodCard(image: "능이백숙", name: "능이백숙", desc: "조용히 알아가는 타입", back: "foodlist03")
                            foodCard(image: "마라탕", name: "마라탕", desc: "화끈한 타입", back: "foodlist03")
                        }
                    }
                    .tag(2)

        
                } //음식 리스트
               .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                // 페이지 인디케이터
                HStack(spacing: 6) {
                    ForEach(0..<foodPages.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.black : Color.gray.opacity(0.4))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.bottom, 10)
            }
            .padding()
            .frame(width: 347, height: 617)
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
