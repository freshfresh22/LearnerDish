//
//  TestDishListView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/19/25.
//

////TEST 이미지 저장 파베에 되고있는지  확인
import SwiftUI

struct TestDishListView: View {
    @StateObject private var firestoreManager = FirestoreManager()

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(firestoreManager.dishes.prefix(12)) { dish in
                    VStack(spacing: 10) {
                        // ✅ 이미지 URL이 있을 때만 출력
                        if let urlString = dish.imageURL, let url = URL(string: urlString) {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 260, height: 260)
                                case .failure:
                                    Image(systemName: "xmark.circle")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            Text("❌ 이미지 URL 없음")
                                .foregroundColor(.red)
                        }

                        Text(dish.nickname)
                            .font(.headline)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            firestoreManager.fetchDishes()
        }
    }
}



////TEST FinalDishList 최종 접시 리스트가 잘 그려지고 있는지 확인
//import SwiftUI
//
//struct TestDishListView: View {
//    @ObservedObject var firestoreManager = FirestoreManager()
//    @State private var selectedDish: DishModel? = nil
//
//    var body: some View {
//        FinalDishList(dishes: firestoreManager.dishes) { dish in
//            selectedDish = dish
//            print("✅ 선택된 디쉬: \(dish.nickname)")
//        }
//        .onAppear {
//            firestoreManager.fetchDishes()
//        }
//    }
//}


////TEST RenderDishView 파베데이터로 접시가 잘 그려지고 있는지 확인
//import SwiftUI
//
//struct TestDishListView: View {
//    @ObservedObject var firestoreManager = FirestoreManager()
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                Text("🍽 불러온 디쉬")
//                    .font(.title)
//                    .bold()
//
//                ForEach(firestoreManager.dishes, id: \.id) { dish in
//                    VStack(spacing: 10) {
//                        // 접시 닉네임도 같이 보기 좋게
//                        Text("👤 \(dish.nickname)의 디쉬")
//                            .font(.headline)
//
//                        RenderedDishView(dish: dish)
//                            .frame(width: 260, height: 260)
//                    }
//                    .padding()
//                    .background(Color.yellow.opacity(0.1))
//                    .cornerRadius(12)
//                }
//            }
//            .padding()
//        }
//        .onAppear {
//            firestoreManager.fetchDishes()
//        }
//    }
//}



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
