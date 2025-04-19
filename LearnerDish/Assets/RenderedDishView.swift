//
//  RenderedDishView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/18/25.
//

// RenderedDishView.swift
import SwiftUI

struct RenderedDishView: View {
    let dish: DishModel // ✅ 이제 모델 하나만 받음
    let size: CGFloat = 220
    let foodSize: CGFloat = 90

    var body: some View {
        ZStack {
            Image(dish.selectedPlate)
                .resizable()
                .frame(width: size, height: size)

            ZStack {
                ForEach(Array(dish.selectedFoods.prefix(4).enumerated()), id: \.offset) { index, name in
                    Image(name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: foodSize, height: foodSize)
                        .position(position(for: index))
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



//#Preview {
//    RenderedDishView(
//        plateImageName: "Plate04",
//        foodImageNames: ["마라탕", "마라탕", "마라탕", "능이백숙"],
//        rotationAngle: 45
//    )
//}
//
