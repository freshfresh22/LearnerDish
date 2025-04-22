//
//  QuestionList.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

//질문 데이터를 저장한 리스트 파일.
//QuestionGroup 단위로 구성돼서 2개의 상반된 옵션을 묶음으로 관리.

import SwiftUI

struct QuestionOption: Identifiable, Equatable {
    let id = UUID()
    let foodText: String
    let foodImage: String
    let plateImage: String
    let lineColor: Color
    let backgroundColor: Color
    let description: String
}

struct QuestionGroup: Identifiable {
    let id = UUID()
    let questionTitle: String
    let options: [QuestionOption]
}

func foodCard(image: String, name: String, desc: String, back: String) -> some View {
    ZStack {
        Image(back) // 배경 이미지
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150)
        
        VStack(spacing: 6) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            Text(name)
            //.font(.headline)
                .font(Font.custom("210 Everybody", size: 23).weight(.bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 0)
            Text(desc)
                .font(.system(size: 13))
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .frame(width: 120, height: 20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.white))
                        .shadow(color: .black.opacity(0.25), radius: 1, x: 0, y: 0)
                    //.stroke(Color.gray,lineWidth: 2)
                )
            
        }
        // .padding()
    }
}


struct QuestionGroupColorPreview: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(allQuestionGroups) { group in
                    HStack(spacing: 10) {
                        ForEach(group.options) { option in
                            VStack(spacing: 4) {
                                Text(option.foodText)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            
                                
                                Rectangle()
                                    .fill(option.backgroundColor)
                                    .frame(width: 60, height: 130)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(option.lineColor, lineWidth: 30)
                                    )
                                    .cornerRadius(4)
                            }
                            .padding(4)
                            .background(Color.white)
                            .cornerRadius(6)
                            .shadow(radius: 1)
                        }
                    }
                    
                    Text(group.questionTitle)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.leading, 4)
                }
            }
            .padding()
        }
    }
}



let allQuestionGroups: [QuestionGroup] = [
    QuestionGroup(
        questionTitle: "새로운 사람을 만났을 때,\n나는 어떤 타입?",
        options: [
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate01",
                lineColor : Color(red: 1, green: 0.95, blue: 0.58),
                backgroundColor: Color.white,
                description: "조용히 알아가는 능이백숙"
            ),
            QuestionOption(
                foodText: "마라탕",
                foodImage: "마라탕",
                plateImage: "Plate02",
                lineColor : Color(red: 1, green: 0.92, blue: 0.81),
                backgroundColor: Color.white,
                description: "불꽃처럼 빠르게 친해지는 \n마라탕"
            )
        ]
    ),
    
    QuestionGroup(
        questionTitle: "혼자 vs 같이 있을 때\n나는 어떤 모습일까?",
        options: [
            QuestionOption(
                foodText: "마라탕",
                foodImage: "마라탕",
                plateImage: "Plate04",
                lineColor : Color(red: 0.93, green: 1, blue: 0.85),
                backgroundColor: Color.white,
                description: "혼자서도 잘 노는 팟타이"
            ),
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate05",
                lineColor : Color(red: 0.73, green: 0.93, blue: 0.64),
                backgroundColor: Color.white,
                description: "여럿이 어울리는 삼겹살"
            )
        ]
    ),
    
    QuestionGroup(
        questionTitle: "3번\n나는 어떤 모습일까?",
        options: [
            QuestionOption(
                foodText: "마라탕",
                foodImage: "마라탕",
                plateImage: "Plate04",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.white,
                description: "혼자서도 잘 노는 팟타이"
            ),
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate05",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.white,
                description: "여럿이 어울리는 삼겹살"
            )
        ]
    ),
    
    QuestionGroup(
        questionTitle: "4번\n나는 어떤 모습일까?",
        options: [
            QuestionOption(
                foodText: "마라탕",
                foodImage: "마라탕",
                plateImage: "Plate04",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.white,
                description: "혼자서도 잘 노는 팟타이"
            ),
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate05",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.white,
                description: "여럿이 어울리는 삼겹살"
            )
        ]
    ),
    
    QuestionGroup(
        questionTitle: "5번\n나는 어떤 모습일까?",
        options: [
            QuestionOption(
                foodText: "마라탕",
                foodImage: "마라탕",
                plateImage: "Plate04",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.white,
                description: "혼자서도 잘 노는 팟타이"
            ),
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate05",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.white,
                description: "여럿이 어울리는 삼겹살"
            )
        ]
    ),
    
]

#Preview {
    QuestionGroupColorPreview()
}
