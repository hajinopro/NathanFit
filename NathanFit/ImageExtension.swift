//
//  ImageExtension.swift
//  NathanFit
//
//  Created by Nathan on 2021/08/26.
//

import SwiftUI

extension Image {
    func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
}
