//
//  ChoiceView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

import SwiftUI

struct ChoiceView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // ✅ 안내 텍스트
            Text("1/4")
                .font(Font.custom("Righteous", size: 23).weight(.medium))
                .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                .frame(width: 344.28, alignment: .leading)
                .padding(.top, 20) // 백버튼보다 살짝 아래
                //.padding(.leading, 0  ) // 좌측 여백
            
            Text("새로운 사람을 만났을 때,\n몇 나는 어떤 타입?")
              .font(.system(size: 24, weight: .semibold))
              .foregroundColor(.black)
              .frame(width: 361, alignment: .topLeading)
              .padding(.top, 10)
              .lineSpacing(3)
            Spacer()
            
            
            
            // 여기에 닉네임 입력 필드 등 추가 예정
            
            // ✅ 하단 버튼
            NavigationLink(destination: FinalDishView()) {
                HStack(alignment: .center, spacing: 10) {
                    Text("등록하기")
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
        ChoiceView()
    }
}

