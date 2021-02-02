//
//  EntryView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct EntryItemView: View {
    let entryInfo: EntryObject
    var body: some View {
        ZStack {
            BlurBackgroundView()
            VStack (alignment: .leading) {
                HStack {
                    if entryInfo.entryTitle != "" {
                    Text(entryInfo.entryTitle)
                        .font(.body)
                        .fontWeight(.medium)
                    } else {
                        Text("Some Item")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(Color(UIColor.systemGray))
                    }
                    Spacer()
                    Text("\(entryInfo.getEntryTotal(), specifier: "%.2f")")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.medium)
                }
                HStack {
                    ForEach (entryInfo.participants, id: \.self) { i in
                        CircleView(index: i, diameter: 10, hasRing: false, ringStroke: 0)
                    }
                    Spacer()
                    Text("\(entryInfo.value, specifier: "%.2f")(\(entryInfo.amount))")
                        .font(.system(.callout, design: .rounded))
                        .foregroundColor(Color(UIColor.systemGray))
                }
            }
            .padding()
        }
        .mask(RoundedRectangle(cornerRadius: 15.0))
        
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryItemView(entryInfo: EntryObject(id: UUID(), entryTitle: "Coke", participants: [0, 3,4], value: 12, amount: 6, withTax: false))
    }
}
