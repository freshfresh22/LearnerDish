//
//  ContentView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/15/25.
//


import SwiftUI

struct ContentView: View {
    @State private var showNextView = false
    @State private var isNicknameRegistered = UserDefaults.standard.bool(forKey: "isNicknameRegistered")
    @StateObject private var user = UserModel()
    
    @State private var shouldStartAtNickNameView = UserDefaults.standard.bool(forKey: "shouldStartAtNickNameView")


    var body: some View {
        NavigationStack {
            ZStack {
                if showNextView {
                    if isNicknameRegistered {
                        //TestDishListView()
                       // InviteView()
                      MainView()
                            .environmentObject(user)
                    } else {
                        MainView()
                        //InviteView()
                            .environmentObject(user)
                    }
                } else {
                    // ✅ 인트로 화면
                    ZStack {
                        CheckBackground(
                            lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                            backgroundColor: Color.white,
                            cornerRadius: 30,
                            opacity: 0.6
                        )

                        VStack {
                            Image("Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 103, height: 74)
                                .offset(y: -10)

                            Text("LEARNER\nDish")
                                .font(Font.custom("Righteous", size: 23))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 1, green: 0.25, blue: 0.23))
                                .frame(width: 188)
                                .offset(y: -10)
                        }
                        .padding()
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showNextView = true
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .environmentObject(user)
    }
}

#Preview {
    ContentView()
}


//import SwiftUI
//
//struct ContentView: View {
//    @State private var showInviteView = false
//    @StateObject private var user = UserModel()
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                if showInviteView {
//                    
//                  // MainView()
//                    //TestDishListView()
//                    InviteView() //🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧다시 수정
//                        .environmentObject(user)
//                } else {
//                    ZStack {
//                        CheckBackground(
//                            lineColor: Color(red: 1, green: 0.94, blue: 0.63),
//                            backgroundColor: Color.white,
//                            cornerRadius: 30,
//                            opacity: 0.6
//                        )
//
//                        VStack {
//                            Image("Logo")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 103, height: 74)
//                                .offset(y: -10)
//
//                            Text("LEARNER\nDish")
//                                .font(Font.custom("Righteous", size: 23))
//                                .multilineTextAlignment(.center)
//                                .foregroundColor(Color(red: 1, green: 0.25, blue: 0.23))
//                                .frame(width: 188)
//                                .offset(y: -10)
//                        }
//                        .padding()
//                    }
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                            withAnimation {
//                                showInviteView = true
//                            }
//                        }
//                    }
//                    .ignoresSafeArea()
//                }
//            }
//        }
//        .environmentObject(user)
//    }
//}
//
//#Preview {
//    ContentView()
//}
