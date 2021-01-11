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
        List {
            VStack {
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
                HStack {
                    ForEach(card.attendees, id: \.self) { attendees in
                        Circle()
                            .fill(dotColors[attendees])
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .padding()
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct SingleCard_Previews: PreviewProvider {
    static var card = BillObject.sample[0]
    static var previews: some View {
        SingleCard(card: card)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
