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
    
    @EnvironmentObject var userModel: UserModel
    
    
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
            
            VStack(spacing: 0) {
                Text("\(dish.nickname)’s")
                  .font(Font.custom("Righteous", size: 35))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                  .frame(width: 360.1781, alignment: .top)
                  .offset(y:-20-40)
                
                Text("Dish")
                  .font(Font.custom("Righteous", size: 35))
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                  .frame(width: 360.1781, alignment: .top)
                  .offset(y:-26-40-5)
                
                RenderedDishView(dish: dish)
                    .frame(width: 260, height: 260)
                    .offset(y:-20-48)
                
                VStack(spacing: 7) { //카드간격
                    ForEach(dish.selectedFoods, id: \.self) { food in
                        if let option = matchedOption(for: food) {
                            HStack(spacing: 10) {
                                Image(option.foodImage)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .padding(.leading, 20)
                                
                                Text(option.description)
                                    .font(Font.custom("210 Everybody", size: 26)
                                        .weight(.black))
                                //.font(.system(size: 16))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .padding(.horizontal, 0.0)
                                
                                Spacer()
                            }
                            .frame(height: 80) //박스 높이
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color(red: 1.0, green: 0.74, blue: 0.14), lineWidth: 6)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(Color.white)
                                            .opacity(0.9)
                                    )
                            )
                            .padding(.horizontal, 12) //좌우 여백
                        }
                    }
                }
                .offset(y:-15-48)

                //Spacer()
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            
            // ✅ 리뷰 바텀시트가 올라와 있을 때 → 배경 덮기
                if showReviewSheet {
//                    Color(red: 1, green: 0.96, blue: 0.73)
//                        //.frame(height:1000)
//                        .ignoresSafeArea(edges:.all)

                    CheckBackground(
                        lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                        backgroundColor: Color.white,
                        cornerRadius: 30,
                        opacity: 1.0
                    )
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: showReviewSheet)
                    .zIndex(1) // 위에 올라오게
                }

            
            CustomBottomSheet(isPresented: $showReviewSheet, nickname: dish.nickname) {
                Group{
                    if let dishID = dish.id {
                        ReviewView(
                            dishOwner: dishID,
                            currentUser: userModel.nickname ?? "익명",
                            currentHeight: 700
                        )
                    } else {
                        Text("접시 정보를 불러오지 못했어요 😢")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                    }
                }
                
            }
            .zIndex(2) // 맨 위
            
            .onAppear {
                print("📌 RunnerDishView 진입")
                print("🧾 dish.id: \(dish.id ?? "nil")")
                print("🍽️ dish.nickname: \(dish.nickname)")
                
            }
            
            .onChange(of: showReviewSheet) { newValue in
                print("✅ showReviewSheet changed to \(newValue)")
                userModel.isReviewVisible = newValue
            }

            
            
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.keyboard, edges: .all)
            .navigationBarTitleDisplayMode(.inline)
                                           
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
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(.keyboard, edges: .all)
    }
    
    
    
    
    
    //#Preview {
    //        RunnerDishView(dish: DishModel(
    //            id: "sampleID",
    //            nickname: "싱싱이",
    //            selectedPlate: "Plate01",
    //            selectedFoods: ["마라탕", "능이백숙", "샤브샤브", "부대찌개"],
    //            rotation: 30, imageURL: ""
    //        ))
    //}
}
