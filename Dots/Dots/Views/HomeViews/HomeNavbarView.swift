//
//  TitleComponent.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct HomeNavbarView: View {
    let activeBillNumber: Int
    var menuAction: () -> ()
    var body: some View {
        VStack (spacing: 20){
            HStack {
                Button(action: {}) {
                    Image(systemName: "list.bullet")
                        .font(.title2)
                }
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus")
                        .font(.title2)
                }
            }
            .padding(.top)
            HStack {
                Text("Active Bills")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
//
            
            
        }
        .padding(.horizontal, 25)
        .frame(maxHeight: 100)
        //        .background(Color(UIColor.systemGray6))
    }
}

struct TitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavbarView(activeBillNumber: 3, menuAction: {})
    }
}
