//
//  MainView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//


//
//  MainView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var firestoreManager = FirestoreManager()
    @State private var showFoodList = false
    @State private var shuffledDishes: [DishModel] = []
    @State private var shuffledDishesID = UUID() // 강제 뷰 갱신

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.yellow.ignoresSafeArea()

                VStack(spacing: -60) {
                    Color(red: 1, green: 0.94, blue: 0.63)
                        .frame(height: 130)
                        .ignoresSafeArea(edges: .top)

                    ScrollView {
                        ZStack(alignment: .top) {
                            CheckBackground(
                                lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                                backgroundColor: .white,
                                cornerRadius: 0,
                                opacity: 0.6
                            )
                            .frame(height: 1000)

                            FinalDishList(
                                dishes: shuffledDishes,
                                onSelect: { dish in
                                    print("✅ 선택된 디쉬: \(dish.nickname)")
                                }
                            )
                            .id(shuffledDishesID)
                            .padding(.top, 40)
                            .offset(y: -40)
                            .background(Color.clear)
                        }
                        .background(Color.clear)
                    }
                    .refreshable {
                        let picked = Array(firestoreManager.dishes.shuffled().prefix(12))
                        shuffledDishes = picked.enumerated().map { index, dish in
                            var updatedDish = dish
                            updatedDish.isLeftAligned = index % 2 == 0
                            return updatedDish
                        }
                        shuffledDishesID = UUID() // 뷰 갱신
                        print("🔄 새로고침 지그재그 셔플됨: \(shuffledDishes.map { ($0.nickname, $0.isLeftAligned ? "←" : "→") })")
                    }
                }

                VStack {
                    ZStack {
                        Text("만나고 싶은 디쉬를 골라보세요")
                            .font(Font.custom("210 Everybody", size: 25).weight(.bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
                            .padding(.vertical, 3)
                            .padding(.horizontal, 18)
                            .background(Color.white)
                            .cornerRadius(30)
                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)

                        HStack {
                            Spacer()
                            Button(action: {
                                showFoodList = true
                            }) {
                                Image("FoodListButton")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .padding(.trailing, 34)
                    }
                    .padding(.top, 10)

                    Spacer()
                }
                .zIndex(1)

                if showFoodList {
                    FoodListView(isPresented: $showFoodList)
                        .background(Color.black.opacity(0.4).ignoresSafeArea())
                        .transition(.opacity)
                        .zIndex(2)
                }
            }
        }
        .onAppear {
            firestoreManager.fetchDishes {
                let picked = Array(firestoreManager.dishes.shuffled().prefix(12))
                shuffledDishes = picked.enumerated().map { index, dish in
                    var updatedDish = dish
                    updatedDish.isLeftAligned = index % 2 == 0
                    return updatedDish
                }
                shuffledDishesID = UUID()
                print("🚀 최초 셔플됨: \(shuffledDishes.map { ($0.nickname, $0.isLeftAligned ? "←" : "→") })")
            }
        }
    }
}


    #Preview {
        MainView()
    }


    
            
//            ZStack {
//                Color.white.ignoresSafeArea()
//                
//                VStack(spacing : 0) {
//                    Color(red: 1, green: 0.94, blue: 0.63)
//                                .frame(height: 130)
//                                .ignoresSafeArea(edges: .top)
//                
//            
//                ScrollView {
//                    ZStack(alignment: .top) {
//                        // ✅ 체크 배경
//                        CheckBackground(
//                            lineColor: Color(red: 1, green: 0.94, blue: 0.63),
//                            backgroundColor: .white,
//                            cornerRadius: 0,
//                            opacity: 0.6
//                        )
//                        .frame(height: 1000) // 👉 적당한 길이로 스크롤 영역 확보
//                    }
//                    .frame(width: geometry.size.width)
//                }
//            }
//
//                // ✅ 중앙 상단 텍스트 + 버튼
//                VStack {
//                    ZStack {
//                        Text("만나고 싶은 디쉬를 골라보세요")
//                            .font(Font.custom("210 Everybody", size: 25).weight(.bold))
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
//                            .padding(.vertical, 3)
//                            .padding(.horizontal, 18)
//                            .background(Color.white)
//                            .cornerRadius(30)
//                            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 4)
//
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                showFoodList = true
//                            }) {
//                                Image("FoodListButton")
//                                    .resizable()
//                                    .frame(width: 24, height: 24)
//                            }
//                        }
//                        .padding(.trailing, 34)
//                    }
//                    .padding(.top, 70)
//
//                    Spacer()
//                }
//
//                // ✅ 팝업
//                // ✅ 팝업
//                if showFoodList {
//                    ZStack {
//                        Color.black.opacity(0.4)
//                            .ignoresSafeArea()
//                            .zIndex(1)
//                        
//                        FoodListView(isPresented: $showFoodList)
//                            .zIndex(2)
//                            .onAppear {
//                                print("foodlistview눌림")
//                            }
//                    }
//                    .transition(.opacity)
//                    .zIndex(10) // 다른 View보다 위로 올림
//                }
//
//            }
//        }
//        .ignoresSafeArea()
//        .onAppear {
//            print("✅ MainView 진입 확인 로그")
//        }
//    }
//}
