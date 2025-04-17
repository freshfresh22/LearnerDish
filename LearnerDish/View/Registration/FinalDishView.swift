//
//  FinalDishVIew.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

import SwiftUI
import FirebaseStorage

struct FinalDishView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: UserModel

    let selectedOptions: [QuestionOption]
    let foodSize: CGFloat = 100

    @State private var randomRotation = Double.random(in: 0..<360)
    @State private var isUploading = false
    @State private var navigateToMain = false // ✅ 화면 전환용 상태 변수 추가

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("메인 디쉬 완성!")
                .font(Font.custom("210 Everybody", size: 35).weight(.bold))
                .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                .frame(width: 344.28, alignment: .leading)
                .padding(.top, 20)

            Text("당신의 디쉬가 완성되었어요!\n만나고 싶은 디쉬를 골라, 디너를 예약해보세요")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 361, alignment: .topLeading)
                .padding(.top, 10)
                .lineSpacing(3)

            VStack {
                Spacer(minLength: 20)
                ZStack {
                    Image("Plate04")
                        .resizable()
                        .frame(width: 360, height: 360)

                    if let plateImage = selectedOptions.first?.plateImage, !plateImage.isEmpty {
                        Image(plateImage)
                            .resizable()
                            .frame(width: 274, height: 277)
                    }

                    ForEach(Array(selectedOptions.prefix(4).enumerated()), id: \.offset) { index, option in
                        Image(option.foodImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: foodSize, height: foodSize)
                            .position(position(for: index))
                    }
                }
                .frame(width: 360, height: 360)
                Spacer(minLength: 20)
            }
            .frame(maxWidth: .infinity)

            NavigationLink(destination: MainView(), isActive: $navigateToMain) {
                EmptyView()
            }.hidden()

            Button(action: {
                print("🟡 디너 예약 버튼 눌림")
                isUploading = true
                user.saveDishMetadata(selectedOptions: selectedOptions, rotationOffset: randomRotation)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isUploading = false
                    navigateToMain = true
                }
            }) {
                Text("디너 예약 잡기")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 361, height: 64)
                    .background(Color(red: 1, green: 0.78, blue: 0.28))
                    .cornerRadius(9)
            }
            .disabled(isUploading)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 15)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbar {
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

    func position(for index: Int) -> CGPoint {
        let center = CGPoint(x: 180, y: 175)
        let radius: CGFloat = 68
        let rotationOffset = Angle(degrees: randomRotation)
        let baseAngle = Angle(degrees: Double(index) * 90)
        let totalAngle = baseAngle + rotationOffset

        let x = center.x + CGFloat(cos(totalAngle.radians)) * radius
        let y = center.y + CGFloat(sin(totalAngle.radians)) * radius
        return CGPoint(x: x, y: y)
    }
}

#Preview {
    NavigationStack {
        FinalDishView(selectedOptions: [
            QuestionOption(foodText: "마라탕", foodImage: "마라탕", plateImage: "Plate02", lineColor: .yellow, backgroundColor: .red, description: ""),
            QuestionOption(foodText: "능이백숙", foodImage: "능이백숙", plateImage: "Plate04", lineColor: .yellow, backgroundColor: .red, description: ""),
            QuestionOption(foodText: "부대찌개", foodImage: "마라탕", plateImage: "Plate05", lineColor: .yellow, backgroundColor: .red, description: ""),
            QuestionOption(foodText: "샤브샤브", foodImage: "마라탕", plateImage: "Plate06", lineColor: .yellow, backgroundColor: .red, description: "")
        ])
        .environmentObject(UserModel())
    }
}

