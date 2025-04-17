//
//  FinalDishList.swift
//  LearnerDish
//
//  Created by 이시은 on 4/17/25.
//

import SwiftUI

struct FinalDishList: View {
    let dishes: [DishModel]
    let onSelect: (DishModel) -> Void // 디쉬 클릭 시 처리할 동작

    var body: some View {
        VStack(spacing: -20) {
            ForEach(Array(dishes.enumerated()), id: \.1.id) { index, dish in
                Button(action: {
                    onSelect(dish)
                }) {
                    Image(uiImage: dish.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 205, height: 205)
                        .clipped()
                        .cornerRadius(20)
                        .shadow(radius: 4)
                }
                .frame(maxWidth: .infinity,
                       alignment: index % 2 == 0 ? .leading : .trailing)
                .padding(.horizontal, 20)
            }
        }
        .padding(.top, 20)
    }
}

// ⚠️ Firebase 연동 시 예상 변경 사항:
//
// 1. DishModel → imageURL (String) 형태로 바뀔 수 있음
//    - Image(uiImage: dish.image) → AsyncImage(url: URL(string: dish.imageURL))
//
// 2. id 값이 UUID() → Firestore ID(String)으로 바뀔 수 있음
//
// 3. 클릭 시 dish 자체를 넘기기보다 dish.id만 넘기고 서버에서 다시 조회하는 방식도 고려 가능


#Preview {
    let previewDishes: [DishModel] = [
        DishModel(image: UIImage(named: "Plate01") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate02") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate03") ?? UIImage()),
        DishModel(image: UIImage(named: "Plate04") ?? UIImage())
    ]

    return FinalDishList(dishes: previewDishes) { selected in
        print("Selected: \(selected.id)")
    }
}


