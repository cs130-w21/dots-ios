//
//  InvertedMask.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

extension View {
    // view.inverseMask(_:)
    public func inverseMask<M: View>(_ mask: M) -> some View {
        // exchange foreground and background
        let inversed = mask
            .foregroundColor(.black)
            .background(Color.white)
            .compositingGroup()
            .luminanceToAlpha()
        return self.mask(inversed)
    }
}
