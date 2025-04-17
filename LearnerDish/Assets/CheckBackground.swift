//
//  CheckBackground.swift
//  LearnerDish
//
//  Created by 이시은 on 4/15/25.
//

import SwiftUI

struct CheckBackground: View {
    var lineColor: Color
    var backgroundColor: Color
    var lineSize: CGFloat = 20
    var spacing: CGFloat = 20
    var opacity: Double = 1.0 // ✅ 새로 추가된 속성

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 배경
                backgroundColor
                    .ignoresSafeArea()

                // 🔥 줄들만 따로 묶어서 blendMode 적용
                ZStack {
                    // 세로 막대
                    ForEach(0..<Int(geometry.size.width / (lineSize + spacing)) + 2, id: \.self) { i in
                        Rectangle()
                            .fill(lineColor.opacity(opacity)) // ✅ 여기 적용
                            .frame(width: lineSize, height: geometry.size.height)
                            .position(
                                x: CGFloat(i) * (lineSize + spacing) + lineSize / 2,
                                y: geometry.size.height / 2
                            )
                    }

                    // 가로 막대
                    ForEach(0..<Int(geometry.size.height / (lineSize + spacing)) + 2, id: \.self) { j in
                        Rectangle()
                            .fill(lineColor.opacity(opacity)) // ✅ 여기 적용
                            .frame(width: geometry.size.width, height: lineSize)
                            .position(
                                x: geometry.size.width / 2,
                                y: CGFloat(j) * (lineSize + spacing) + lineSize / 2
                            )
                    }
                }
                .blendMode(.multiply)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .ignoresSafeArea()
    }
}



#Preview {
    CheckBackground(lineColor: Color(red: 1, green: 0.94, blue: 0.63), backgroundColor: Color(red: 100, green: 100, blue: 100),opacity: 0.6)
}
