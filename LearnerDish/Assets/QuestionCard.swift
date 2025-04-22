//
//  QuestionCard.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

//질문 카드 UI 컴포넌트.
//체크 식탁보 + 접시 + 음식 이미지 + 텍스트, 모든 질문 공통으로 사용

import SwiftUI

struct QuestionCard: View {
    let lineColor: Color
    let backgroundColor: Color
    let plateImage: String
    let foodImage: String
    let foodText: String
    let description: String
    let isSelected: Bool
    let selectionBorderColor: Color
    
    var body: some View {
        ZStack {
            CheckBackground(
                lineColor: lineColor,
                backgroundColor: backgroundColor,
                cornerRadius: 20
            )
            .frame(width: 360, height: 270)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? selectionBorderColor : .clear, lineWidth: 0)
            )
            
            // 접시 + 설명
            VStack(spacing: 7) {
                
                Image(plateImage)
                    .resizable()
                    .frame(width: 210, height: 210)
                
                Text(description)
                    .font(.system(size: 19))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white.opacity(0.9))
                            .frame(height: 25)
                    )
            }
            .padding(.top, 10)
            
            // 음식 텍스트 + 음식 이미지
            
            VStack(spacing: 4) {
                Text(foodText)
                    .font(Font.custom("210 Everybody", size: 34).weight(.bold))
                    .foregroundColor(.black)
                    //.padding(.horizontal, 6)
                    //.padding(.vertical, 20)
                   .offset(y:22)
                
                Image(foodImage)
                    .resizable()
                    .scaledToFit()
                    .padding(.top,10)
                    .frame(width: 210, height: 100)
                    .offset(y:10)
            }
            .offset(y: -30) // ✅ 위치 조정해서 접시 위로 띄우기
        }
    }
    
    //#preview
    struct QuestionCard_Previews: PreviewProvider {
        static var previews: some View {
            QuestionCard(
                lineColor : Color(red: 1.0, green: 0.95, blue: 0.75),
                backgroundColor: Color(red: 1.0, green: 0.95, blue: 0.75),
                plateImage: "Plate01",
                foodImage: "능이백숙",
                foodText: "능이백숙",
                description: "조용히 알아가는 능이백숙 타입",
                isSelected: true,
                selectionBorderColor: .orange
            )
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
