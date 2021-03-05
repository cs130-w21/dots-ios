//
//  CircleView.swift
//  Dots
//
//  Created by Jack Zhao on 1/11/21.
//

import SwiftUI

/// A circular icon that is used to represent each individual.
struct CircleView: View {
    /// Index of the circular icon
    let index: Int
    /// Diameter of the circular icon
    let diameter: Double
    /// Deprecated: Boolean value that decides whether the circle has ring.
    let hasRing: Bool
    /// Radius of the circle.
    private let radius: CGFloat
    private let ringStroke: Double
    /// Initialize `CircleView`.
    /// - Parameters:
    ///   - index: index that represents the dot.
    ///   - diameter: diameter of the dot.
    ///   - hasRing: Deprecated: Boolean value that decides whether the circle has ring.
    ///   - ringStroke: Size of the stroke.
    init (index: Int = 0, diameter: Double = 30, hasRing: Bool = false, ringStroke: Double = 8) {
        self.index = index
        self.diameter = diameter
        self.hasRing = hasRing
        self.ringStroke = ringStroke
        self.radius = self.hasRing ? CGFloat(diameter - self.ringStroke) : CGFloat(diameter)
    }
    /// Circle body view.
    var body: some View {
        ZStack {
            if (self.hasRing) {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: CGFloat(self.diameter), height: CGFloat(self.diameter))
            }
            Circle()
                .foregroundColor(classic.dotColors[index])
                .frame(width: self.radius, height: self.radius)
        }
    }
}


struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(index: 1, diameter: 30, hasRing: false, ringStroke: 8)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
