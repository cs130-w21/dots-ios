//
//  HomeTitleView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct TopEdgeBlur: View {
    var body: some View {
        VStack {
            BlurBackgroundView(style: .systemChromeMaterial)
                .frame(maxHeight: 60)
                .ignoresSafeArea()
                .offset(y:-60)
            
            Spacer()
        }
    }
}

struct HomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TopEdgeBlur()
    }
}
