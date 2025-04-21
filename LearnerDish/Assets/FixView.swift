//
//  FixView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/21/25.
//

import SwiftUI

struct FixView: View {
    @State private var goToNickName = false
    @EnvironmentObject var userModel: UserModel

    var body: some View {
        NavigationStack {
            NavigationLink(destination: NickNameView().environmentObject(userModel), isActive: $goToNickName) {
                EmptyView()
            }
            .hidden()
            .onAppear {
                print("🔁 FixView: NickNameView로 이동 중")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    goToNickName = true
                }
            }

            Color.clear // 실제로는 아무 UI도 없음
        }
    }
}
