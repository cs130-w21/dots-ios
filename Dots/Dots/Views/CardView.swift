//
//  SingleCard.swift
//  Dots
//
//  Created by Guanqun Ma on 1/10/21.
//

import SwiftUI
import UIKit

struct CardView: View {
    @Binding var card: BillObject
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    HStack {
                        Text(card.title)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.semibold)
                        if self.card.paid {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                        
                    }
                    Spacer()
                    Text("$" + String(card.billAmount))
                        .fontWeight(.semibold)
                        .font(.system(.title, design: .rounded))
                    
                    
                }.padding(.horizontal)
                
                VStack {
                    Spacer()
                    HStack {
                        Text(self.card.getDate())
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(Color(UIColor.systemGray))
                            .padding(.leading)
                            .padding(.bottom, 0.3 * geo.frame(in: .global).height)
                        Spacer()
                    }
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        HStack (spacing: 5) {
                            CircleView(index: self.card.initiator, diameter: 26, hasRing: true, ringStroke: 5)
                            ForEach(card.attendees, id: \.self) { d in
                                if (d != self.card.initiator) {
                                    CircleView(index: d, diameter: 20, hasRing: true, ringStroke: 5)
                                }
                            }
                        }
                        .padding(.trailing)
                        .padding(.top, 0.3 * geo.frame(in: .global).height + 9)
                    }
                    Spacer()
                }
            }
            .background(BlurView())
        }
    }
}

struct SingleCard_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .constant(BillObject.sample[0]))
            .previewLayout(.sizeThatFits)
            .frame(height: 300, alignment: .center)
    }
}
