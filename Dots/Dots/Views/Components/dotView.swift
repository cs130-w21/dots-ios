//
//  dotView.swift
//  Dots
//
//  Created by Jack Zhao on 2/22/21.
//

import SwiftUI

struct dotView: View {
    var index: Int
    var tapped: Bool
    var size: CGFloat
    var body: some View {
        let imageName = self.tapped ? "largecircle.fill.circle" : "circle.fill"
        return
            Image(systemName: imageName)
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(classic.dotColors[index])
    }
}
