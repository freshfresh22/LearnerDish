//
//  RunnerDishView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//
import SwiftUI

struct RunnerDishView: View {
    let dish: DishModel
    var showToolbar: Bool = true  // ← 기본값 true로 두면 기존 코드 다 유지 가능
    
    @Environment(\.dismiss) var dismiss
    @State private var showReviewSheet = false

    func matchedOption(for foodName: String) -> QuestionOption? {
        for group in allQuestionGroups {
            if let match = group.options.first(where: { $0.foodText == foodName }) {
                return match
            }
        }
        return nil
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            CheckBackground(
                lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                backgroundColor: Color.white,
                cornerRadius: 30,
                opacity: 0.6
            )

            VStack(spacing: 20) {
                Text("\(dish.nickname)’s Dish")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.red)

                RenderedDishView(dish: dish)
                    .frame(width: 260, height: 260)

                ForEach(dish.selectedFoods, id: \.self) { food in
                    if let option = matchedOption(for: food) {
                        HStack(spacing: 10) {
                            Image(option.foodImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text(option.description)
                                .font(.system(size: 16))
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    }
                }

                Spacer()
            }
            .padding()

            CustomBottomSheet(isPresented: $showReviewSheet) {
                ReviewView(
                    dishID: dish.id ?? "",
                    currentUser: dish.nickname, currentHeight: 70
                )
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            if showToolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image("Backbutton")
                            .resizable()
                            .frame(width: 19, height: 19)
                    }
                }
            }
        }
    }
}





#Preview {
        RunnerDishView(dish: DishModel(
            id: "sampleID",
            nickname: "싱싱이",
            selectedPlate: "Plate01",
            selectedFoods: ["마라탕", "능이백숙", "샤브샤브", "부대찌개"],
            rotation: 30, imageURL: ""
        ))
}
