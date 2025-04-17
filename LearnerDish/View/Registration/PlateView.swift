//
//  'PlateView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/15/25.
//

import SwiftUI

struct PlateView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentPlateIndex: Int = 0
    
    @EnvironmentObject var user: UserModel

    
    let plates = samplePlates // PlateModel.swift의 plate 데이터

    var body: some View {
        VStack(spacing: 0) {
            // 안내 텍스트
            Text("요리하기")
                .font(Font.custom("210 Everybody", size: 35).weight(.bold))
                .foregroundColor(Color(red: 1, green: 0.22, blue: 0.1))
                .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 끝까지 밀기
                .padding(.horizontal, 15) // 좌우 여백 주면 더 보기 좋음
                .padding(.top, 20)

            
            Text("나만의 메인 디쉬를 요리해볼까요?\n몇 가지 질문에 답하면\n당신 취향대로 플레이팅된 접시가 완성됩니다")
              .font(.system(size: 20, weight: .semibold))
              .foregroundColor(.black)
              .frame(width: 361, alignment: .topLeading)
              .padding(.top, 10)
              .lineSpacing(3)
              //Spacer()
            
            
            
            // 접시 선택
            VStack {
                //Spacer(minLength: 40) // 안내문과 살짝 띄움
                
                HStack {
                    Button(action: {
                        withAnimation {
                            currentPlateIndex = (currentPlateIndex - 1 + plates.count) % plates.count
                        }
                    }) {
                        Image("chevron.left")
                            .font(.title)
                            .foregroundColor(.gray)
                    }

                    Image(plates[currentPlateIndex].imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 274, height: 277)
                        .padding(.horizontal)

                    Button(action: {
                        withAnimation {
                            currentPlateIndex = (currentPlateIndex + 1) % plates.count
                        }
                    }) {
                        Image("chevron.right")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 65)
                
                Text("접시를 선택해주세요.")
                  .font(
                    Font.custom("210 Everybody", size: 26)
                      .weight(.bold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.43, green: 0.43, blue: 0.43))
                  .frame(width: 360.1781, alignment: .top)
                  .offset(y:-50)
                
                Spacer(minLength: 30) // 버튼과도 띄움
            }
            .frame(maxWidth: .infinity)
            
            // 하단 버튼
            NavigationLink(destination: ChoiceView()) {
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
            .simultaneousGesture(TapGesture().onEnded {
                print("✅ 등록 버튼 눌림")
                user.selectedPlate = plates[currentPlateIndex] // ✅ 접시 선택
                user.savePlateToFirebase() // ✅ 파이어베이스에 저장
            })
            
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
        PlateView()
            .environmentObject(UserModel())
    }
}



