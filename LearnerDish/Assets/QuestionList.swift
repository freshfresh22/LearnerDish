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

let allQuestionGroups: [QuestionGroup] = [
    QuestionGroup(
        questionTitle: "새로운 사람을 만났을 때,\n나는 어떤 타입?",
        options: [
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate01",
                lineColor : Color(red: 0.81, green: 0.94, blue: 1),
                backgroundColor: Color(red: 1.0, green: 0.97, blue: 0.7),
                description: "조용히 알아가는 능이백숙 타입"
            ),
            QuestionOption(
                foodText: "마라탕",
                foodImage: "마라탕",
                plateImage: "Plate02",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color(red: 1.0, green: 0.8, blue: 0.7),
                description: "불꽃처럼 빠르게 친해지는 마라탕 타입"
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
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.mint,
                description: "혼자서도 잘 노는 팟타이"
            ),
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate05",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.green,
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
                backgroundColor: Color.mint,
                description: "혼자서도 잘 노는 팟타이"
            ),
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate05",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.green,
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
                backgroundColor: Color.mint,
                description: "혼자서도 잘 노는 팟타이"
            ),
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate05",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.green,
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
                backgroundColor: Color.mint,
                description: "혼자서도 잘 노는 팟타이"
            ),
            QuestionOption(
                foodText: "능이백숙",
                foodImage: "능이백숙",
                plateImage: "Plate05",
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color.green,
                description: "여럿이 어울리는 삼겹살"
            )
        ]
    ),
    
]
