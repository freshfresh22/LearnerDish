//
//  FinalDishVIew.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

//import SwiftUI
//import FirebaseStorage
//
//struct FinalDishView: View {
//    @Environment(\.dismiss) var dismiss
//    @EnvironmentObject var user: UserModel
//
//    let selectedOptions: [QuestionOption]
//    let foodSize: CGFloat = 100 // ✅ 음식 이미지 크기 조절
//
//    @State private var randomRotation = Double.random(in: 0..<360)
//    @State private var isUploading = false
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            Text("메인 디쉬 완성!")
//                .font(Font.custom("210 Everybody", size: 35).weight(.bold))
//                .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
//                .frame(width: 344.28, alignment: .leading)
//                .padding(.top, 20)
//
//            Text("당신의 디쉬가 완성되었어요!\n만나고 싶은 디쉬를 골라, 디너를 예약해보세요")
//                .font(.system(size: 20, weight: .semibold))
//                .foregroundColor(.black)
//                .frame(width: 361, alignment: .topLeading)
//                .padding(.top, 10)
//                .lineSpacing(3)
//
//            VStack {
//                Spacer(minLength: 20)
//                ZStack {
//                    Image("Plate04")
//                        .resizable()
//                        .frame(width: 360, height: 360)
//
//                    if let plateImage = selectedOptions.first?.plateImage, !plateImage.isEmpty {
//                        Image(plateImage)
//                            .resizable()
//                            .frame(width: 274, height: 277)
//                    }
//
//                    ForEach(Array(selectedOptions.prefix(4).enumerated()), id: \.offset) { index, option in
//                        Image(option.foodImage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: foodSize, height: foodSize)
//                            .position(position(for: index))
//                    }
//                }
//                .frame(width: 360, height: 360)
//                Spacer(minLength: 20)
//            }
//            .frame(maxWidth: .infinity)
//
//            NavigationLink(destination: MainView()) {
//                Text("디너 예약 잡기")
//                    .font(.system(size: 20, weight: .semibold))
//                    .foregroundColor(.black)
//                    .frame(width: 361, height: 64)
//                    .background(Color(red: 1, green: 0.78, blue: 0.28))
//                    .cornerRadius(9)
//            }
//            .disabled(isUploading)
//            .simultaneousGesture(TapGesture().onEnded {
//                print("🟡 디너 예약 버튼 눌림")
//                if let image = renderDishImage() {
//                    print("🖼️ 이미지 렌더링 성공, 저장 시작")
//                    isUploading = true
//                    $user.uploadDishImageAndSave(selectedOptions: selectedOptions, image: image) { result in
//                        isUploading = false
//                        switch result {
//                        case .success(let url):
//                            print("✅ 이미지 업로드 및 Firestore 저장 성공: \(url.absoluteString)")
//                        case .failure(let error):
//                            print("❌ 업로드 실패: \(error.localizedDescription)")
//                        }
//                    }
//                } else {
//                    print("❌ 이미지 렌더링 실패")
//                }
//            })
//            .padding(.bottom, 40)
//        }
//        .padding(.horizontal, 15)
//        .navigationBarTitle("")
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    dismiss()
//                }) {
//                    Image("Backbutton")
//                        .resizable()
//                        .frame(width: 19, height: 19)
//                }
//            }
//        }
//    }
//
//    func position(for index: Int) -> CGPoint {
//        let center = CGPoint(x: 180, y: 175)
//        let radius: CGFloat = 68
//        let rotationOffset = Angle(degrees: randomRotation)
//        let baseAngle = Angle(degrees: Double(index) * 90)
//        let totalAngle = baseAngle + rotationOffset
//
//        let x = center.x + CGFloat(cos(totalAngle.radians)) * radius
//        let y = center.y + CGFloat(sin(totalAngle.radians)) * radius
//        return CGPoint(x: x, y: y)
//    }
//
//    func renderDishImage() -> UIImage? {
//        let controller = UIHostingController(rootView:
//            ZStack {
//                Image("Plate05")
//                    .resizable()
//                    .frame(width: 360, height: 360)
//
//                if let plateImage = selectedOptions.first?.plateImage, !plateImage.isEmpty {
//                    Image(plateImage)
//                        .resizable()
//                        .frame(width: 274, height: 277)
//                }
//
//                ForEach(Array(selectedOptions.prefix(4).enumerated()), id: \.offset) { index, option in
//                    Image(option.foodImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: foodSize, height: foodSize)
//                        .position(position(for: index))
//                }
//            }
//            .frame(width: 360, height: 360)
//        )
//
//        let view = controller.view
//        let size = CGSize(width: 360, height: 360)
//        view?.bounds = CGRect(origin: .zero, size: size)
//        view?.backgroundColor = .clear
//
//        let renderer = UIGraphicsImageRenderer(size: size)
//        return renderer.image { _ in
//            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        FinalDishView(selectedOptions: [
//            QuestionOption(foodText: "마라탕", foodImage: "마라탕", plateImage: "Plate02", lineColor: .yellow, backgroundColor: .red, description: ""),
//            QuestionOption(foodText: "능이백숙", foodImage: "능이백숙", plateImage: "Plate04", lineColor: .yellow, backgroundColor: .red, description: ""),
//            QuestionOption(foodText: "부대찌개", foodImage: "마라탕", plateImage: "Plate05", lineColor: .yellow, backgroundColor: .red, description: ""),
//            QuestionOption(foodText: "샤브샤브", foodImage: "마라탕", plateImage: "Plate06", lineColor: .yellow, backgroundColor: .red, description: "")
//        ])
//    }
//}
//
