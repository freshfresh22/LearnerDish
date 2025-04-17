//
//  ChoiceView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

import SwiftUI

struct ChoiceView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: UserModel
    
    @State private var selectedOptions: [QuestionOption] = []
    @State private var currentIndex: Int = 0
    @State private var questionGroups: [QuestionGroup] = []
    
    //private let questionGroups = Array(allQuestionGroups.shuffled().prefix(4))
    
    var body: some View {
        Group {
            if currentIndex < questionGroups.count {
                let currentGroup = questionGroups[currentIndex]
                
                VStack(spacing: 20) {
                    // 질문 번호
                    Text("\(currentIndex + 1)/\(questionGroups.count)")
                        .font(Font.custom("Righteous-Regular", size: 30).weight(.bold))
                        .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                        .frame(width: 344.28, height: 0, alignment: .leading)
                        .padding(.top, 30)
                        .offset(x: -6)
                    
                    // 질문 text
                    Text(currentGroup.questionTitle)
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 361, height: 80, alignment: .topLeading)
                        .lineSpacing(3)
                        .lineLimit(2)
                        .offset(y: 7)
                    
                    // 선택지
                    VStack(spacing: 20) {
                        ForEach(currentGroup.options, id: \.id) { option in
                            Button(action: {
                                if selectedOptions.count > currentIndex {
                                    selectedOptions[currentIndex] = option
                                } else {
                                    selectedOptions.append(option)
                                }
                                currentIndex += 1
                            }) {
                                QuestionCard(
                                    lineColor: option.lineColor,
                                    backgroundColor: option.backgroundColor,
                                    plateImage: option.plateImage,
                                    foodImage: option.foodImage,
                                    foodText: option.foodText,
                                    description: option.description,
                                    isSelected: selectedOptions.count > currentIndex && selectedOptions[currentIndex].id == option.id,
                                    selectionBorderColor: .orange
                                )
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
            } else {
                FinalDishView(selectedOptions: selectedOptions)
                    .environmentObject(user)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    if currentIndex == 0 {
                        dismiss()
                    } else {
                        currentIndex -= 1
                    }
                }) {
                    Image("Backbutton")
                        .resizable()
                        .frame(width: 19, height: 19)
                }
            }
        }
        .onAppear {
            if questionGroups.isEmpty {
                questionGroups = Array(allQuestionGroups.shuffled().prefix(4))
                print("✅ 질문 로딩됨")
            }
        }
    }
}



//#Preview {
//    NavigationStack {
//        ChoiceView()
//            .environmentObject(UserModel())
//    }
//}
