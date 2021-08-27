//
//  RatingView.swift
//  NathanFit
//
//  Created by Nathan on 2021/08/26.
//

import SwiftUI

struct RatingView: View {
    @AppStorage("ratings") private var ratings = "4031"
    @State private var rating = 0
    let exerciseIndex: Int
    
    let maximumRating = 5
    let offColor = Color.gray
    let onColor = Color.red
    
    fileprivate func convertRating() {
        let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
        let char = ratings[index]
        rating = char.wholeNumberValue ?? 0
    }
    
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1) { item in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(item > rating ? offColor : onColor)
                    .onTapGesture {
                        updateRating(item: item)
                    }
                    .onAppear {
                        convertRating()
                    }
                    .onChange(of: ratings) { _ in
                        convertRating()
                    }
            }
        }
        .font(.largeTitle)
    }
    
    func updateRating(item: Int) {
        rating = item
        let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
        ratings.replaceSubrange(index ... index, with: String(rating))
    }
}

struct RatingView_Previews: PreviewProvider {
    @AppStorage("ratings") static var ratings: String?
    
    static var previews: some View {
        ratings = nil
        return RatingView(exerciseIndex: 0)
            .previewLayout(.sizeThatFits)
    }
}
