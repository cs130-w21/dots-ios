//
//  TitleComponent.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct HomeNavbarView: View {
    let topLeftButtonView: String
    let topRightButtonView: String
    let titleString: String
    var topLeftButtonAction: () -> ()
    var topRightButtonAction: () -> ()
    
    var body: some View {
        VStack (spacing: 20){
            HStack {
                if topLeftButtonView != "" {
                    Button(action: topLeftButtonAction) {
                        Image(systemName: topLeftButtonView)
                            .font(.title2)
                    }
                } else {
                    Text(" ")
                        .font(.title2)
                }
                Spacer()
                if topRightButtonView != "" {
                    Button(action: topRightButtonAction) {
                        Image(systemName: topRightButtonView)
                            .font(.title2)
                    }
                } else {
                    Text(" ")
                        .font(.title2)
                }
            }
            .foregroundColor(Color.primary)
            .padding(.top)
            
            HStack {
                Text(titleString)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                Spacer()
            }
        }
        .padding(.horizontal, 25)
        .frame(maxHeight: 100)
    }
}

struct TitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavbarView(topLeftButtonView: "calendar", topRightButtonView: "plus", titleString: "Title", topLeftButtonAction: {}, topRightButtonAction: {})
    }
}
