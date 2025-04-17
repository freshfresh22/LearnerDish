//
//  MainView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

import SwiftUI

struct MainView: View {
    let dishCount: Int = 12
    @State private var showFoodList = false

    // ✅ 임시 데이터
    let sampleDishes: [DishModel] = [
        DishModel(image: UIImage(named: "Plate01") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate02") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate03") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate04") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate05") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate03") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate01") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate02") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate03") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate04") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate05") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate03") ?? UIImage())
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    ZStack(alignment: .top) {
                        // ✅ 체크 배경
                        CheckBackground(
                            lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                            backgroundColor: .white,
                            cornerRadius: 0,
                            opacity: 0.6
                        )
                        .frame(height: CGFloat(dishCount) * 160 + 540)

                        // ✅ 접시 리스트 (지그재그)
                        FinalDishList(dishes: sampleDishes) { dish in
                            // do nothing for now
                        }
                        .padding(.top, 110)
                    }
                    .frame(width: geometry.size.width)
                }

                // ✅ 중앙 상단 텍스트 + 버튼
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
                    .padding(.top, 70)

                    Spacer()
                }

                // ✅ 팝업으로 FoodListView
                if showFoodList {
                    FoodListView(isPresented: $showFoodList)
                        .background(Color.black.opacity(0.4).ignoresSafeArea())
                        .transition(.opacity)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
