//
//  FinalDishList.swift
//  LearnerDish
//
//  Created by 이시은 on 4/17/25.
//


import SwiftUI

struct FinalDishList: View {
    let dishes: [DishModel]
    let onSelect: (DishModel) -> Void

    var body: some View {
        VStack(spacing: -20) {
            ForEach(Array(dishes.prefix(12).enumerated()), id: \.offset) { index, dish in
                Button(action: {
                    onSelect(dish)
                }) {
                    RenderedDishView(dish: dish)
                        .frame(width: 260, height: 260)
                        .padding(.horizontal, 20)
                        .frame(
                            maxWidth: .infinity,
                            alignment: index % 2 == 0 ? .leading : .trailing
                        )
                }
            }
        }
        .padding(.top, 20)
        .background(Color.clear)
    }
}

//네비게이션 중복 제거
//import SwiftUI
//
//struct FinalDishList: View {
//    let dishes: [DishModel]
//    let onSelect: (DishModel) -> Void
//
//    
//    @State private var selectedDish: DishModel?
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: -20) {
//                ForEach(Array(dishes.prefix(12).enumerated()), id: \.0) { index, dish in
//                    NavigationLink(
//                        destination: RunnerDishView(dish: dish),
//                        label: {
//                            RenderedDishView(dish: dish)
//                            .frame(width: 260, height: 260)
//                            .padding(.horizontal, 20)
//                            .frame(
//                                maxWidth: .infinity,
//                                alignment: index % 2 == 0 ? .leading : .trailing
//                            )
//                        }
//                    )
//                    .background(Color.clear)
//                    .simultaneousGesture(TapGesture().onEnded {
//                        selectedDish = dish
//                        onSelect(dish)
//                    })
//                }
//            }
//            .padding(.top, 20)
//            .background(Color.clear)
//        }
//    }
//}


//#Preview {
//    let sampleDishes: [DishModel] = [
//        DishModel(id: "1", nickname: "시은", selectedPlate: "Plate01", selectedFoods: ["마라탕", "마라탕", "마라탕", "마라탕"], rotation: 0),
//        DishModel(id: "2", nickname: "사용자", selectedPlate: "Plate02", selectedFoods: ["마라탕", "마라탕", "마라탕", "마라탕"], rotation: 45),
//        DishModel(id: "3", nickname: "사용자", selectedPlate: "Plate02", selectedFoods: ["마라탕", "마라탕", "마라탕", "마라탕"], rotation: 45),
//        DishModel(id: "4", nickname: "사용자", selectedPlate: "Plate02", selectedFoods: ["마라탕", "마라탕", "마라탕", "마라탕"], rotation: 45)
//    ]
//
//    FinalDishList(dishes: sampleDishes) { selectedDish in
//        print("✅ 클릭된 접시: \(selectedDish.nickname)")
//    }
//}
