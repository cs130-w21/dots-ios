//
//  HomeTitleView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct HomeTitleView: View {
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 10) {
                HStack {
                    // Replace with logo
                    Image(systemName: "circle.fill")
                    Spacer()
                    Button(action: {
                        print("hi")
                    }) {
                        Image(systemName: "ellipsis")
                            .font(.title2)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top)
                Text("Active Bills")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 25)
                Spacer()
            }
            .frame(maxHeight: 100)
            .background(BlurView(active: true, onTap: {}))
            Spacer()
        }
    }
}

struct HomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitleView()
    }
}
