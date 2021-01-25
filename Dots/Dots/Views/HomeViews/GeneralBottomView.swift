//
//  HomeBottomView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct GeneralBottomView: View {
    var buttonText: String
    var alternativeText: String
    var confirmFunc: () -> ()
    var alternativeFunc: () -> ()
    var body: some View {
        
        VStack {
            Spacer()
            VStack {
                Button(action: confirmFunc) {
                    RoundedRectangle(cornerRadius: 20.0)
                        .overlay(Text(buttonText).foregroundColor(.white).bold())
                        .frame(maxWidth: 280, maxHeight: 55)
                }
                Button(action: alternativeFunc) {
                    Text(alternativeText)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .ignoresSafeArea()
            .padding(.top, 30)
            .frame(maxWidth: screen.width, maxHeight: 150)
            .background(Color(UIColor.systemGray6))
            .mask(CustomShape(radius: 25.0).rotation(Angle(degrees: 180)))
            .shadow(color: Color(UIColor.systemGray5),radius: 5, x:0, y: -10)
        }
        .ignoresSafeArea()
        
    }
}

struct HomeBottomView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralBottomView(buttonText: "Done", alternativeText: "maybe later", confirmFunc: {}, alternativeFunc: {})
    }
}
