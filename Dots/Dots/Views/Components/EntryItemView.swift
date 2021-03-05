//
//  EntryView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

/// Displays the information of current entry.
struct EntryItemView: View {
    /// An `EntryObject` instance that contains all the information of an entry.
    let entryInfo: EntryObject?
    /// Tax rate of the parent bill.
    let taxRate: Double
    
    /// Define minimum scale coefficient that the text size can shrink.
    let minScaleFactor: CGFloat = 0.5
    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
    
    /// Entry item body view.
    var body: some View {
        ZStack {
            entryBackground()
            if entryInfo == nil {
                
                Label (title: { Text("Add Entry") } , icon: {
                    Image(systemName: "plus")
                })
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color.gray)
                
            } else {
                VStack (alignment: .leading, spacing: 10) {
                    HStack {
                        if entryInfo!.entryTitle != "" {
                            Text(entryInfo!.entryTitle)
                                .font(.body)
                                .fontWeight(.medium)
                                .foregroundColor(mainTextColor())
                                .minimumScaleFactor(minScaleFactor)
                                .lineLimit(1)
                        } else {
                            Text("Item")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(Color(UIColor.systemGray2))
                        }
                        Spacer()
                        Text("\(self.actualEntryTotal(), specifier: "%.2f")")
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(mainTextColor())
                            .minimumScaleFactor(minScaleFactor)
                            .lineLimit(1)
                        
                    }
                    HStack (alignment: .top) {
                        if (entryInfo!.participants.count > 5) {
                            VStack (alignment: .leading) {
                                HStack {
                                    ForEach (0..<5, id: \.self) { i in
                                        CircleView(index: entryInfo!.participants[i], diameter: 10, hasRing: false, ringStroke: 0)
                                    }
                                }
                                HStack {
                                    ForEach (5..<entryInfo!.participants.count, id: \.self) { i in
                                        CircleView(index: entryInfo!.participants[i], diameter: 10, hasRing: false, ringStroke: 0)
                                    }
                                }
                            }
                        } else {
                            ForEach (entryInfo!.participants, id: \.self) { i in
                                CircleView(index: i, diameter: 10, hasRing: false, ringStroke: 0)
                            }
                        }
                        Spacer()
                        HStack (alignment: .top, spacing: 4) {
                            Text("\(entryInfo!.value, specifier: "%.2f")(\(entryInfo!.amount))")
                                .font(.system(.footnote, design: .rounded))
                                .foregroundColor(Color(UIColor.systemGray))
                                .minimumScaleFactor(minScaleFactor)
                                .lineLimit(1)
                            
                            if (self.entryInfo!.withTax) {
                                Text("+tax \(self.getEntryTax(), specifier: "%.2f")")
                                    .font(.system(.footnote, design: .rounded))
                                    .foregroundColor(Color(UIColor.systemGray))
                                    .minimumScaleFactor(minScaleFactor)
                                    .lineLimit(1)
                            }
                            
                        }
                    }
                }
                .padding()
            }
            
        }
    }
    
    private func actualEntryTotal() -> Double {
        return self.entryInfo!.withTax ? self.entryInfo!.getEntryTotal() + getEntryTax() : self.entryInfo!.getEntryTotal()
    }
    
    private func getEntryTax() -> Double {
        return self.entryInfo!.getEntryTotal() * taxRate/100.0
    }
    
    private func mainTextColor() -> Color {
        if scheme == .light {
            return classic.primaryTextColor
        }
        else {
            return Color.primary
        }
    }
    
    private func entryBackground() -> some View {
        if scheme == .light {
            return Color(UIColor(rgb: 0xD2CECE)).opacity(0.2)
        }
        else {
            return Color(UIColor.systemGray6)
        }
        
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        //        EntryItemView(entryInfo: EntryObject(id: UUID(), entryTitle: "", participants: [0,1, 2,3,4,5], value: 12, amount: 6, withTax: true), taxRate: 12)
        EntryItemView(entryInfo: nil, taxRate: 12)
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            .frame(width: 340)
    }
}
