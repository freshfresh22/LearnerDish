//
//  InviteView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/15/25.
//

import SwiftUI

struct InviteView: View {
    @State private var showNext = false
    @State private var goToNickName = false

    // 👉 외부에서 전달받을 플래그
    var shouldSkipUI: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                // ✅ Navigation 자동 전환 (수정 흐름일 때만 실행됨)
                NavigationLink(
                    destination: NickNameView(),
                    isActive: $goToNickName
                ) {
                    EmptyView()
                }

                // ✅ 수정 흐름이면 UI 생략
                if shouldSkipUI {
                    EmptyView()
                        .onAppear {
                            print("🔁 수정 흐름 InviteView: 바로 NickNameView로 이동")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                goToNickName = true
                            }
                        }

                } else {
                    // ✅ 기존 초대장 흐름 유지
                    if showNext {
                        // 두 번째 화면
                        ZStack {
                            CheckBackground(
                                lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                                backgroundColor: Color.white, cornerRadius: 30,
                                opacity: 0.6
                            )

                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 361, height: 564.62048)
                                .background(Color(red: 1, green: 0.91, blue: 0.51))
                                .cornerRadius(19)
                                .offset(y: -40)

                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 324.82001, height: 512.95001)
                                .background(
                                    Image("Invitation")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 324.82, height: 512.95)
                                        .clipped()
                                        .offset(y: -40)
                                )

                            VStack {
                                Spacer()

                                VStack(spacing: 20) {
                                    Image("Logo")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 75, height: 54)
                                        .offset(y: -40)

                                    Text("INVITATION")
                                        .font(Font.custom("Righteous", size: 23))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                                        .frame(width: 187.60693, alignment: .top)
                                        .offset(y: -50)

                                    (
                                        Text("""
                                        누군가와 가까워지는 데엔  
                                        말보다 밥이 먼저일 때가 있죠 :)

                                        그래서 준비했어요!  
                                        오늘, 당신의 식탁 위에도  
                                        조금 특별한 접시 하나를 올려보려 해요.

                                        당신을
                                        """)
                                        +
                                        Text(" 러너 디쉬 ")
                                            .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                                            .font(Font.custom("210 Everybody", size: 24).weight(.bold))
                                        +
                                        Text("에 초대합니다!")
                                    )
                                    .font(Font.custom("210 Everybody", size: 24).weight(.bold))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .frame(width: 360.01123, alignment: .top)
                                    .offset(y: -5)
                                }

                                Spacer()

                                NavigationLink(destination: NickNameView()) {
                                    Text("수락하기")
                                        .font(.system(size: 20, weight: .semibold))
                                        .foregroundColor(.black)
                                        .frame(width: 361, height: 64)
                                        .background(Color(red: 1, green: 0.78, blue: 0.28))
                                        .cornerRadius(9)
                                }
                                .padding(.bottom, 40)
                            }
                            .padding()
                        }
                        .transition(.opacity)

                    } else {
                        // 첫 번째 화면
                        VStack {
                            Text("띵동!\n초대장이 도착했어요")
                                .font(Font.custom("210 Everybody", size: 28).weight(.bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .frame(width: 361)
                                .lineSpacing(20)
                                .offset(y: -70)

                            Image("Letter")
                                .frame(width: 117.5, height: 83.5)
                                .offset(y: -50)
                        }
                        .transition(.opacity)
                    }
                }
            }
            .animation(.easeInOut(duration: 0.5), value: showNext)
            .onAppear {
                if !shouldSkipUI {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            showNext = true
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    InviteView()
}
