//
//  dotView.swift
//  Dots
//
//  Created by Jack Zhao on 2/22/21.
//

import SwiftUI

/// Dot view.
struct dotView: View {
    /// Index of the dot.
    var index: Int
    /// Boolean value that indicates whether the dot is tapped.
    var tapped: Bool
    /// Size of the dot.
    var size: CGFloat
    /// Dot body view.
    var body: some View {
        let imageName = self.tapped ? "largecircle.fill.circle" : "circle.fill"
        return
            Image(systemName: imageName)
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(classic.dotColors[index])
    }
}
