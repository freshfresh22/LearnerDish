//
//  NickNameView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/15/25.
//

//닉네임 버튼 입력 x -> 버튼 비활성화 추가

import SwiftUI

struct NickNameView: View {
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
            
            // 닉네임 입력 필드 + 원형 이름표
            ZStack(alignment: .top) {
                // 1. 원형 이름표 (가장 뒤에 위치)
                Circle()
                    .fill(Color(red: 1, green: 0.78, blue: 0.28))
                    .frame(width: 116, height: 116)
                    .offset(y: 35) // 🔽 좀 더 밑으로 내림
                    .zIndex(0) // 가장 뒤
                
                VStack(spacing: 4) {
                    Image("NickLogo")
                        .resizable()
                        .frame(width: 41.61185, height: 30.0878)
                        .offset(y: 44)
                    
                    Text("CHEF")
                        .font(Font.custom("Righteous", size: 18.35455))
                        .foregroundColor(.white)
                        .offset(y: 42)
                }
                
                // 2. 닉네임 입력 박스
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 361, height: 108.86133)
                    .cornerRadius(10.18422)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.18422)
                            .inset(by: 4.5)
                            .stroke(Color(red: 1, green: 0.78, blue: 0.28), lineWidth: 9)
                    )
                    .offset(y:95)
                    .zIndex(1) // 중간
                
                // 3. 텍스트필드
                VStack(spacing: 4) {
                    Spacer().frame(height: 20)
                    TextField("닉네임을 입력해주세요", text: $nickname)
                        .font(Font.custom("210 Everybody", size: 30).weight(.bold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.43, green: 0.43, blue: 0.43))
                        .frame(width: 320)
                        .textInputAutocapitalization(.none) // 선택사항
                        .disableAutocorrection(true) // 선택사항
                        .offset(y:83)
                }
                .frame(height: 108.86133)
                .zIndex(2) // 가장 앞
            }
            .frame(height: 160) // 전체 높이 조절
            
            
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
                    guard !nickname.isEmpty else { return }
                        user.nickname = nickname
                        user.saveNicknameToFirebase() // 🔥 저장!
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
        NickNameView()
    }
}
