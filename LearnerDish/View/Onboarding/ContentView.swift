//
//  ContentView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showInviteView = false

    var body: some View {
        ZStack {
            if showInviteView {
                InviteView() // ✅ InviteView로 교체됨 (뒤로가기 없음)
            } else {
                ZStack {
                    // 배경
                    CheckBackground(
                        lineColor: Color(red: 1, green: 0.94, blue: 0.63),
                        backgroundColor: Color.white,
                        opacity: 0.6
                    )

                    // 콘텐츠
                    VStack {
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 103.02515, height: 74.49134)
                            .offset(y: -10)

                        Text("LEARNER\nDish")
                            .font(Font.custom("Righteous", size: 23.38345))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 1, green: 0.25, blue: 0.23))
                            .frame(width: 187.60693, alignment: .top)
                            .offset(y: -10)
                    }
                    .padding()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            showInviteView = true
                        }
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
}


#Preview {
    ContentView()
}
