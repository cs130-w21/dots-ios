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
            ZStack {
//                VStack (alignment: .leading, spacing: 10) {
//                    HStack {
//                        // Replace with logo
//                        Image(systemName: "circle.fill")
//                        Spacer()
//                        Button(action: {
//                            // TODO: Menu button action
//                            print("hi")
//                        }) {
//                            Image(systemName: "ellipsis")
//                                .font(.title)
//                        }
//                    }
//                    .padding(.horizontal, 25)
//                    .padding(.top)
//                    Text("Active Bills")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 25)
//                    Spacer()
//                }
//                .frame(maxHeight: 100)
//                .background(Color(UIColor.systemGray))
                
                BlurView(active: true, onTap: {})
                    .frame(maxHeight: 60)
                    .ignoresSafeArea()
                    .offset(y:-60)
                
            }
            Spacer()
        }
    }
}

struct HomeTitleView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitleView()
    }
}
