//
//  SingleCard.swift
//  Dots
//
//  Created by Guanqun Ma on 1/10/21.
//

import SwiftUI

struct SingleCard: View {
    let card: BillObject
    var body: some View {
        ZStack {
            VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(card.title)
                                if card.paid {
                                    Image(systemName: "checkmark.circle.fill")
                                }
                                else {
                                    Image(systemName: "checkmark.circle")
                                }
                            }
                            Text("Date")
                        }
                        Spacer()
                        Text("$" + String(card.billAmount))
                    }
                    Spacer()
                }
                .padding()
                VStack {
                    Spacer()
                    HStack {
                            ForEach(card.attendees, id: \.self) { attendees in
                                Circle()
                                    .fill(dotColors[attendees])
                                    .frame(width: 20, height: 20)
                            }
                    }
                    .padding()
                }
        }
        .frame(width: 300, height: 200, alignment: .center)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 30, x: 0, y: 10)
    }
}

struct SingleCard_Previews: PreviewProvider {
    static var card = BillObject.sample[0]
    static var previews: some View {
        SingleCard(card: card)
            .previewLayout(.sizeThatFits)
    }
}
