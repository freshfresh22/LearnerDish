//
//  ReviewCardView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/20/25.
//

// ReviewCardView.swift
import SwiftUI

struct ReviewCardView: View {
    let review: Review
    let isMine: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(isMine ? "\(review.author) (나)" : review.author)
                    .font(.headline)
                    .foregroundColor(.red)
                Spacer()
                Text("수정 | 삭제")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text(review.content)
                .font(.body)

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "text.bubble")
                    Text("\(review.comments)")
                }
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(review.likes)")
                }
                Spacer()
                Text(dateToString(review.date))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(red: 1.0, green: 0.96, blue: 0.8))
        .cornerRadius(16)
    }

    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}
