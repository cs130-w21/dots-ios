//
//  HomeBottomView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

/// Home bottom View.
struct HomeBottomView: View {
    /// A string of text on button.
    var buttonText: String
    /// The secondary text of button.
    var secondaryButtonText: String
    /// Confirm action function.
    var confirmFunc: () -> ()
    /// Secondary action function.
    var secondaryFunc: () -> ()
    /// Background color.
    var backgroundColor: Color
    
    /// Home buttom view.
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 16){
                Button(action: confirmFunc) {
                    RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                        .overlay(Text(buttonText).foregroundColor(.white).bold())
                        .frame(maxWidth: 200, maxHeight: 45)
                }
                Button(action: secondaryFunc) {
                    Text(secondaryButtonText)
                        .font(.caption)
                }
                .accessibility(identifier: "homeBottomHide")
                
                Spacer()
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, maxHeight: 110)
            .background(LinearGradient(gradient: Gradient(colors: [
                backgroundColor.opacity(1), backgroundColor.opacity(1), backgroundColor.opacity(1), backgroundColor.opacity(0)
            ]), startPoint: .bottom, endPoint: .top))
        }
        .ignoresSafeArea()
    }
}
