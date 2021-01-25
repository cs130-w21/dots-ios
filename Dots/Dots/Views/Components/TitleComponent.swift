//
//  TitleComponent.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct TitleComponent: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            HStack {
                // Replace with logo
                Image(systemName: "circle.fill")
                Spacer()
                Button(action: {
                    // TODO: Menu button action
                    print("hi")
                }) {
                    Image(systemName: "ellipsis")
                        .font(.title)
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
        .background(Color(UIColor.systemGray6))
    }
}

struct TitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        TitleComponent()
    }
}
