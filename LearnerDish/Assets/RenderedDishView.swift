//
//  RenderedDishView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/18/25.
//

// RenderedDishView.swift



//기존방식 그냥 불러오기
//import SwiftUI
//
//struct RenderedDishView: View {
//    let dish: DishModel // ✅ 이제 모델 하나만 받음
//    let size: CGFloat = 220
//    let foodSize: CGFloat = 90
//
//    var body: some View {
//        ZStack {
//            Image(dish.selectedPlate)
//                .resizable()
//                .frame(width: size, height: size)
//
//            ZStack {
//                ForEach(Array(dish.selectedFoods.prefix(4).enumerated()), id: \.offset) { index, name in
//                    Image(name)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: foodSize, height: foodSize)
//                        .position(position(for: index))
//                }
//            }
//            .rotationEffect(.degrees(dish.rotation))
//            .frame(width: size, height: size)
//        }
//        .frame(width: size, height: size)
//        .background(Color.clear)
//    }
//
//    private func position(for index: Int) -> CGPoint {
//        let center = CGPoint(x: size / 2, y: size / 2)
//        let radius: CGFloat = 60
//        let angle = Angle(degrees: Double(index) * 90)
//        let x = center.x + CGFloat(cos(angle.radians)) * radius
//        let y = center.y + CGFloat(sin(angle.radians)) * radius
//        return CGPoint(x: x, y: y)
//    }
//}



//#Preview {
//    RenderedDishView(
//        plateImageName: "Plate04",
//        foodImageNames: ["마라탕", "마라탕", "마라탕", "능이백숙"],
//        rotationAngle: 45
//    )
//}
//

import SwiftUI

struct RenderedDishView: View {
    let dish: DishModel // ✅ 이제 모델 하나만 받음
    let size: CGFloat = 230 //러너디쉬뷰도 바뀜
    let foodSize: CGFloat = 90

    @State private var localID = UUID().uuidString // ✅ 상태로 관리되는 ID (String)
    @State private var isLeftAligned = Bool.random() // ✅ 렌더링 시 좌우 배치 랜덤 처리

    var body: some View {
        HStack {
            if isLeftAligned {
                contentView
                Spacer()
            } else {
                Spacer()
                contentView
            }
        }
        .padding(.horizontal, 20)
        .frame(width: size + 40)
        .id(dish.id ?? localID)
        .onChange(of: dish.id) { _ in
            localID = UUID().uuidString
            isLeftAligned = Bool.random()
        }
    }

    var contentView: some View {
        ZStack {
            Image(dish.selectedPlate)
                .resizable()
                .frame(width: size, height: size)
                .shadow(radius: 5)

            ZStack {
                ForEach(Array(dish.selectedFoods.prefix(4).enumerated()), id: \ .offset) { offset, foodName in
                    Image(foodName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: foodSize, height: foodSize)
                        .position(position(for: offset))
                }
            }
            .rotationEffect(.degrees(dish.rotation))
            .frame(width: size, height: size)
        }
        .frame(width: size, height: size)
        .background(Color.clear)
    }

    private func position(for index: Int) -> CGPoint {
        let center = CGPoint(x: size / 2, y: size / 2)
        let radius: CGFloat = 60
        let angle = Angle(degrees: Double(index) * 90)
        let x = center.x + CGFloat(cos(angle.radians)) * radius
        let y = center.y + CGFloat(sin(angle.radians)) * radius
        return CGPoint(x: x, y: y)
    }
}
