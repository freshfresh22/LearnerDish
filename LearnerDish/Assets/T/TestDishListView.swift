//
//  TestDishListView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/19/25.
//


//TEST RenderDishView 파베데이터로 접시가 잘 그려지고 있는지 확인
import SwiftUI

struct TestDishListView: View {
    @ObservedObject var firestoreManager = FirestoreManager()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("🍽 불러온 디쉬")
                    .font(.title)
                    .bold()

                ForEach(firestoreManager.dishes, id: \.id) { dish in
                    VStack(spacing: 10) {
                        // 접시 닉네임도 같이 보기 좋게
                        Text("👤 \(dish.nickname)의 디쉬")
                            .font(.headline)

                        RenderedDishView(dish: dish)
                            .frame(width: 260, height: 260)
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .onAppear {
            firestoreManager.fetchDishes()
        }
    }
}



//Test DishModel 파이어베이스의 디쉬모델을 잘 불러오고 있는지 확인 테스트
//import SwiftUI
//
//struct TestDishListView: View {
//    @ObservedObject var firestoreManager = FirestoreManager()
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text("🍽 불러온 디쉬 리스트")
//                .font(.title2)
//                .bold()
//                .padding(.top)
//
//            if firestoreManager.dishes.isEmpty {
//                Text("아직 불러온 디쉬가 없어요.")
//                    .foregroundColor(.gray)
//            } else {
//                ScrollView {
//                    ForEach(firestoreManager.dishes, id: \.id) { dish in
//                        VStack(alignment: .leading, spacing: 6) {
//                            Text("🥄 닉네임: \(dish.nickname)")
//                            Text("🍽 접시: \(dish.selectedPlate)")
//                            Text("🍱 음식 수: \(dish.selectedFoods.count)")
//                            Text("🌀 회전값: \(Int(dish.rotation))도")
//                        }
//                        .padding()
//                        .background(Color.yellow.opacity(0.1))
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                    }
//                }
//            }
//
//            Spacer()
//        }
//        .padding()
//        .onAppear {
//            firestoreManager.fetchDishes()
//        }
//    }
//}
