//
//  iconView.swift
//  Dots
//
//  Created by Jack Zhao on 1/13/21.
//

import SwiftUI

struct iconView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                HStack {
                    Circle()
                        .frame(width: 110, height: 110, alignment: .center)
                    Circle()
                        .frame(width: 110, height: 110, alignment: .center)
                        .offset(y: 8)
                    Circle()
                        .frame(width: 110, height: 110, alignment: .center)
                        .offset(x: -13, y: 60)
                }
                Circle()
                    .frame(width: 110, height: 110, alignment: .center)
                HStack {
                    Circle()
                        .frame(width: 110, height: 110, alignment: .center)
                    Circle()
                        .frame(width: 110, height: 110, alignment: .center)
                        .offset(y: -8)
                    Circle()
                        .foregroundColor(.orange)
                        .frame(width: 110, height: 110, alignment: .center)
                        .offset(x: -13, y: -60)
                }
                Spacer()
            }
            .offset(x: 10)
            .foregroundColor(.red)
            .shadow(radius: 5, x:0, y:5)
           
        }
        .frame(width: 512, height: 512)
    }
}

struct iconView_Previews: PreviewProvider {
    static var previews: some View {
        iconView()
            .previewLayout(.sizeThatFits)
    }
}
