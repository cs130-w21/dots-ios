//
//  SingleCard.swift
//  Dots
//
//  Created by Guanqun Ma on 1/10/21.
//

import SwiftUI

struct CardView: View {
    @Binding var card: BillObject
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack {
                    CircleView(index: self.card.initiator, diameter: 30, hasRing: false, ringStroke: 3)
                    ForEach(card.attendees, id: \.self) { d in
                        if (d != self.card.initiator) {
                            CircleView(index: d, diameter: 20, hasRing: false, ringStroke: 3)
                        }
                    }
                }
                .padding(.bottom)
            }
            VStack {
                Spacer()
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(card.title)
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.semibold)
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                        Text(self.card.getDate())
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(Color(UIColor.systemGray))
                    }
                    Spacer()
                    Text("$" + String(card.billAmount))
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct SingleCard_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .constant(BillObject.sample[0]))
            .previewLayout(.sizeThatFits)
    }
}
