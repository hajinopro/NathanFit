//
//  RatingView.swift
//  NathanFit
//
//  Created by Nathan on 2021/08/26.
//

import SwiftUI

struct RatingView: View {
    var body: some View {
        HStack {
            ForEach(0 ..< 5) { _ in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(.gray)
            }
        }
        .font(.largeTitle)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
            .previewLayout(.sizeThatFits)
    }
}
