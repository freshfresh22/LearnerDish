//
//  FoodListVIew.swift
//  LearnerDish
//
//  Created by 이시은 on 4/17/25.
//

import SwiftUI

struct FoodListView: View {
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 320, height: 400)
                .shadow(radius: 10)

            VStack(spacing: 20) {
                HStack {
                    Text("🍽️ Food List")
                        .font(.headline)
                        .foregroundColor(.red)

                    Spacer()

                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                Spacer()

                Text("여기에 음식 리스트가 들어갑니다.")
                    .foregroundColor(.gray)

                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).ignoresSafeArea()) // 팝업 시 어두워짐
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
    }
}

#Preview {
    FoodListView(isPresented: .constant(true))
}

