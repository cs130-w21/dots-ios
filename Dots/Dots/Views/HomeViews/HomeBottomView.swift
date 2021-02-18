//
//  HomeBottomView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct HomeBottomView: View {
    var buttonText: String
    var confirmFunc: () -> ()
    var backgroundColor: Color
    
    var body: some View {
        
        VStack {
            Spacer()
            VStack {
                Button(action: confirmFunc) {
                    RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                        .overlay(Text(buttonText).foregroundColor(.white).bold())
                        .frame(maxWidth: 200, maxHeight: 45)
                }
                Spacer()
            }
            .padding(.top, 10)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: 110)
            .background(LinearGradient(gradient: Gradient(colors: [
                backgroundColor.opacity(1), backgroundColor.opacity(1), backgroundColor.opacity(1), backgroundColor.opacity(0)
            ]), startPoint: .bottom, endPoint: .top))
//            .mask(CustomShape(radius: 25.0).rotation(Angle(degrees: 180)))
        }
        .ignoresSafeArea()
        
    }
}

struct HomeBottomView_Previews: PreviewProvider {
    static var previews: some View {
        HomeBottomView(buttonText: "Calculate", confirmFunc: {}, backgroundColor: Color.red)
    }
}
