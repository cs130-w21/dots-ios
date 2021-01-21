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
        HStack(spacing: 0) {
            Rectangle()
                .frame(maxWidth: 16)
                .foregroundColor(dotColors[self.card.initiator])
            ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
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
                    .fontWeight(.semibold)
                    .font(.system(.title, design: .rounded))
                    
                    
            }.padding(.horizontal)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .frame(maxWidth: 36, maxHeight: 36)
                        .foregroundColor(dotColors[self.card.initiator])
                        .opacity(0.8)
                    ForEach(card.attendees, id: \.self) { d in
                        if (d != self.card.initiator) {
                            Circle()
                                .frame(maxWidth: 20, maxHeight: 20)
                                .foregroundColor(dotColors[d])
                                .opacity(1)
                        }
                    }
                    Spacer()
                }
                .padding(.bottom)
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
