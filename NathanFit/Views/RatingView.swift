//
//  RatingView.swift
//  NathanFit
//
//  Created by Nathan on 2021/08/26.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    let maximumRating = 5
    let offColor = Color.gray
    let onColor = Color.red
    
    var body: some View {
        HStack {
            ForEach(1 ..< maximumRating + 1) { item in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(item > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = item
                    }
            }
        }
        .font(.largeTitle)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
            .previewLayout(.sizeThatFits)
    }
}
