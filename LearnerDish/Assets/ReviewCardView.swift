//
//  ReviewCardView.swift
//  LearnerDish
//
//  Created by 이시은 on 4/20/25.
//


import SwiftUI



struct ReviewCardView: View {
    let review: Review
    let isMine: Bool
    let onDelete: () -> Void    // 삭제 콜백 추가
    

    var body: some View {
        ZStack {
            // 🔻 이미지 배경
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 371, height: 184)
              .background(
                Image("ReviewCard")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 372, height: 148)
                  .clipped()
              )
            
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 341, height: 116)
              .background(.white)
              .cornerRadius(13)
            
            // 🔺 카드 내용
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(isMine ? "\(review.author)(나)" : review.author)
                      .font(
                        Font.custom("210 Everybody", size: 26)
                            .weight(.black)
                      )
                      .foregroundColor(Color(red: 1, green: 0.22, blue: 0.09))
                      .frame(width: 265, height: 23.05371, alignment: .leading)
                      .padding(.leading)
                    
                    Spacer()
                    if isMine {
                        Button(action: onDelete) {
                            
                            Text("삭제")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing, 15.0)
                             
                        }
                    }
                }


                Text(review.content)
                    .font(.system(size: 18, weight: .semibold))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 16)

                HStack {
                    Spacer()
                    Text(dateToString(review.date))
                        .font(.system(size: 15, weight: .semibold))
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 15)
                }
            }
            .padding()
           // .background(Color(red: 1.0, green: 0.96, blue: 0.8))
           // .cornerRadius(16)
        }
    }


    func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}


// ReviewCardView.swift
//import SwiftUI
//
//struct ReviewCardView: View {
//    let review: Review
//    let isMine: Bool
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(isMine ? "\(review.author) (나)" : review.author)
//                    .font(.headline)
//                    .foregroundColor(.red)
//                Spacer()
//                Text("수정 | 삭제")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//
//            Text(review.content)
//                .font(.body)
//
//            HStack(spacing: 16) {
//                HStack(spacing: 4) {
//                    Image(systemName: "text.bubble")
//                    Text("\(review.comments)")
//                }
//                HStack(spacing: 4) {
//                    Image(systemName: "heart.fill")
//                        .foregroundColor(.red)
//                    Text("\(review.likes)")
//                }
//                Spacer()
//                Text(dateToString(review.date))
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//        }
//        .padding()
//        .background(Color(red: 1.0, green: 0.96, blue: 0.8))
//        .cornerRadius(16)
//    }
//
//    func dateToString(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy.MM.dd"
//        return formatter.string(from: date)
//    }
//}
