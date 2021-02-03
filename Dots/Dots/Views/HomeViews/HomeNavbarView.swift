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
        HStack {
            VStack (alignment: .leading, spacing: 10) {
                
                Text("You have \(activeBillNumber) active bills")
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.light)
                    .foregroundColor(Color(UIColor.systemGray))
                
                Text("Active Bills")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding(.top)
            
            Spacer()
            
            Menu {
                Button(action: {}, label: {
                    Label("Add Bill", systemImage: "minus.circle")
                })
                Button(action: {}, label: {
                    Text("Button")
                })
                Button(action: {}, label: {
                    Text("Button")
                })
            } label: {
                Image(systemName: "ellipsis")
                    .font(.title)
            }
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
