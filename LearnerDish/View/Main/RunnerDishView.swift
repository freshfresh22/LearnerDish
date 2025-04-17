//
//  RunnerDishView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//

import SwiftUI

struct RunnerDishView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: UserModel //닉네임 저장
    @State private var nickname: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 안내 텍스트
            Text("셰프의 이름을 적어주세요!")
                .font(Font.custom("210 Everybody", size: 35).weight(.bold))
                .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                .frame(width: 344.28, alignment: .leading)
                .padding(.top, 20)
            
            Text("당신만의 레시피로 디쉬를 꾸며줄\n셰프의 닉네임 알려주세요.")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 361, alignment: .topLeading)
                .padding(.top, 10)
                .lineSpacing(3)
            
            Spacer().frame(height: 40)
            
            
            Spacer()
            
            // 하단 버튼
            VStack {
                NavigationLink(destination: PlateView())
                {
                    HStack(alignment: .center, spacing: 10) {
                        Text("등록하기")
                            .font(.system(size: 20, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                    .padding(.vertical, 11)
                    .frame(width: 361, height: 64.19385, alignment: .center)
                    .background(Color(red: 1, green: 0.78, blue: 0.28))
                    .cornerRadius(9)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    user.nickname = nickname
                })

                .padding(.bottom, 40)
            }
        }
        .ignoresSafeArea(.keyboard)
        
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
        .padding(.horizontal, 16) // 좌우 여백 추가 (필요시 조절)
    }
}

#Preview {
    NavigationStack {
        RunnerDishView()
    }
}

