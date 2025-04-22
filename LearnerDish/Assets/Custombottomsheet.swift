//
//  Custombottomsheet.swift
//  LearnerDish
//
//  Created by 이시은 on 4/20/25.
//

import SwiftUI

struct CustomBottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let nickname: String
    let content: () -> Content
    

    private let collapsedHeight: CGFloat = 100
    private let expandedHeight: CGFloat = 760

    @GestureState private var dragOffset: CGFloat = 0
    @State private var isExpanded: Bool = false
    @FocusState private var isInputFocused: Bool
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                // ✅ REVIEW 텍스트 + 지붕
                ZStack {
                    GeometryReader {geometry in
                        Image("SheetRoof")
                            .resizable() // ← 꼭 필요
                            .aspectRatio(contentMode: .fit) // ← 비율 유지하며 꽉 차게
                            .frame(width: geometry.size.width + 50) // ← 너비만 주면 높이는 자동 계산됨
                            .padding(.horizontal, -25)
                            .offset(y: 0)
                    }
                    .frame(height: 114) // ✅ 전체 높이는 적당히 한정해줘야 함

                    Text("\(nickname) REVIEW")
                        .font(Font.custom("Righteous", size: 23))
                        .foregroundColor(.red)
                        .offset(y: -5)
                }
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.25)) {
                        isExpanded = true
                        isPresented = true
                    }
                }

                // ✅ 흰색 박스 + 내용
                VStack(spacing: 0) {
                    content()

//                    Spacer()
//
//                    HStack {
//                        TextField("리뷰 쓰기...", text: .constant(""))
//                            .textFieldStyle(.roundedBorder)
//                            .focused($isInputFocused)
//                            .padding(.horizontal)
//
//                        Button("등록") {}
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 8)
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                            .padding(.trailing)
//                    }
//                    .padding(.bottom, keyboardHeight + geo.safeAreaInsets.bottom + 80)
                }
                .frame(height: expandedHeight - 80)
                .background(Color.white)
            }
            .frame(width: geo.size.width)
            .offset(y: geo.size.height - (isExpanded ? expandedHeight : collapsedHeight) + dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        if value.translation.height < -50 {
                            isExpanded = true
                            isPresented = true
                        } else if value.translation.height > 50 {
                            isExpanded = false
                            isPresented = false
                            isInputFocused = false
                            
                            //키보드도 같이 닫기
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                        }
                    }
            )
            .onReceive(
                NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            ) { notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    let screenHeight = UIScreen.main.bounds.height
                    let safeAreaBottom = geo.safeAreaInsets.bottom
                    let keyboardTopY = keyboardFrame.origin.y

                    withAnimation(.easeOut(duration: 0.5)) {
                        keyboardHeight = max(0, screenHeight - keyboardTopY - safeAreaBottom)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .ignoresSafeArea(.keyboard)
    }
}
