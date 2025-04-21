//
//  MyDishView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/16/25.
//


import SwiftUI

struct MyDishView: View {
    @EnvironmentObject var userModel: UserModel
    @Environment(\.dismiss) var dismiss

    @State private var goToNickNameView = false
    @State private var showDeleteAlert = false
    
    @State private var goToFixView = false


    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let myDish = userModel.dishes.first {
                RunnerDishView(dish: myDish, showToolbar: false)
            } else {
                Text("내 접시가 아직 없습니다 😢")
                    .font(.title3)
                    .padding()
            }

            // ✅ 수정하기 + 계정삭제 버튼 묶음
            VStack(alignment: .trailing, spacing: 10) {
                Button(action: {
                    goToNickNameView = true
                }) {
                    Text("수정하기")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 14)
                        .background(Color(red: 1, green: 0.44, blue: 0.39))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }

                Button(action: {
                    showDeleteAlert = true
                }) {
                    Text("계정삭제")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 14)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
            }
            .padding(.top, 50)
            .padding(.trailing, 20)

            // ✅ 닉네임 등록부터 다시 시작
            NavigationLink(
                destination: NickNameView()
                    .navigationBarBackButtonHidden(true),
                isActive: $goToNickNameView
            ) {
                EmptyView()
            }
        }
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
        .alert("정말 계정을 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
            Button("삭제", role: .destructive) {
                userModel.deleteAccountAndResetApp()
            }
            Button("취소", role: .cancel) {}
        }
    }
}

