//
//  HomeBottomView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct HomeBottomView: View {
    var addBillFunc: () -> ()
    var completeBillFunc: () -> ()
    var body: some View {
        
        VStack {
            Spacer()
            VStack {
                Button(action: addBillFunc) {
                    RoundedRectangle(cornerRadius: 20.0)
                        .overlay(Text("+ Add Bill").foregroundColor(.white).bold())
                        .frame(maxWidth: 280, maxHeight: 55)
                }
                Button(action: completeBillFunc) {
                    Text("Complete Bills")
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
        HomeBottomView(addBillFunc: {}, completeBillFunc: {})
            .previewDevice("iPad Pro (9.7-inch)")
    }
}
