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
            }
            // ✅ 수정하기 + 계정삭제 버튼 묶음
            HStack() {
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Text("수정하기") //계정 삭제 기능으로 변경
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .stroke(Color(red: 0.46, green: 0.77, blue: 1), lineWidth: 3))
                }
                .background(Color.clear.opacity(0.3))
                .opacity(userModel.isReviewVisible ? 0 : 1)
                .padding(.bottom)
                
                /*
                 Button(action: {
                 userModel.resetForEdit()
                 goToFixView = true
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
                 */ //수정하기 버튼 -> inviteview이동
            }
            .padding(.trailing, 20)
            
            // ✅ 리뷰 바텀시트 올라왔을 때 상단 버튼 가리는 배경
            //            if userModel.isReviewVisible {
            //                CheckBackground(
            //                    lineColor: Color(red: 1, green: 0.94, blue: 0.63),
            //                    backgroundColor: Color.white,
            //                    cornerRadius: 30,
            //                    opacity: 0.5
            //                )
            //                .ignoresSafeArea()
            //                //.frame(height:100)
            //                .transition(.opacity)
            //                .zIndex(10)
            //            }
            
            NavigationLink(destination: FixView().environmentObject(userModel), isActive: $goToFixView) {
                EmptyView()
            }
            
            // ✅ 닉네임 등록부터 다시 시작
            //            NavigationLink(
            //                destination: NickNameView()
            //                    .navigationBarBackButtonHidden(true),
            //                isActive: $goToNickNameView
            //            ) {
            //                EmptyView()
            //            }
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
        .alert("닉네임/메인 디쉬를 수정하시겠습니까?", isPresented: $showDeleteAlert) {
            Button("삭제", role: .destructive) {
                userModel.deleteAccountAndResetApp()
            }
            Button("취소", role: .cancel) {}
        }
    }
}

#Preview {
    MyDishView()
        .environmentObject(UserModel())
}
