//
//  FinalDishVIew.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

import SwiftUI

struct FinalDishView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // ✅ 안내 텍스트
            Text("메인 디쉬 완성!")
                .font(Font.custom("210 Everybody", size: 35).weight(.bold))
                .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                .frame(width: 344.28, alignment: .leading)
                .padding(.top, 20) // 백버튼보다 살짝 아래
                //.padding(.leading, 0  ) // 좌측 여백
            
            Text("당신의 디쉬가 완성되었어요!\n만나고 싶은 디쉬를 골라, 디너를 예약해보세요")
              .font(.system(size: 20, weight: .semibold))
              .foregroundColor(.black)
              .frame(width: 361, alignment: .topLeading)
              .padding(.top, 10)
              .lineSpacing(3)
            Spacer()
            
            
            
            // 여기에 닉네임 입력 필드 등 추가 예정
            
            // ✅ 하단 버튼
            NavigationLink(destination: ChoiceView()) {
                HStack(alignment: .center, spacing: 10) {
                    Text("디너 예약 잡기")
                        .font(.system(size: 20, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 0)
                .padding(.vertical, 11)
                .frame(width: 361, height: 64.19385, alignment: .center)
                .background(Color(red: 1, green: 0.78, blue: 0.28))
                .cornerRadius(9)
            }

            .padding(.bottom, 40) // 하단 여백
        }
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
                        .padding(.leading, 0)
                }
            }
        }
    }
}




#Preview {
    NavigationStack {
        FinalDishView()
    }
}

