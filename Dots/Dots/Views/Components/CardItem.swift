//
//  CardItem.swift
//  Dots
//
//  Created by Jack Zhao on 1/25/21.
//

import SwiftUI


/// A card view that displays a summary of the bill.
struct CardItem: View {
    
    /// A BillObject value passed into the view.
    var card: BillObject

    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(self.card.getDate())
                    .foregroundColor(Color.gray)
                    .font(.system(.caption, design: .rounded))
                Text(self.card.title)
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(mainTextColor())
            }
            Spacer()
            VStack (alignment: .trailing, spacing: 0){
                    Text("$ \(self.card.billAmount, specifier: "%.2f")")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(mainTextColor())
                    
                    // MARK: Dots
                    VStack  {
                        if self.card.attendees.count > 5 {
                            VStack (alignment: .trailing) {
                                HStack (spacing: 5) {
                                    ForEach(0 ..< 5) { index in
                                        // TODO: Replace circle view
                                        CircleView(index: self.card.attendees[index], diameter: 15, hasRing: false, ringStroke: 0)
                                    }
                                }
                                HStack (spacing: 5) {
                                    ForEach(5 ..< self.card.attendees.count) { index in
                                        // TODO: Replace circle view
                                        CircleView(index: self.card.attendees[index], diameter: 15, hasRing: false, ringStroke: 0)
                                    }
                                }
                            }
                        }
                        else {
                            HStack (spacing: 5) {
                                ForEach(self.card.attendees, id: \.self) { index in
                                    // TODO: Replace circle view
                                    CircleView(index: self.card.attendees[index], diameter: 15, hasRing: false, ringStroke: 0)
                                }
                            }
                        }
                    }
                    .offset(y: 5)
                }
                .offset(y: self.card.attendees.count > 5 ? 10 : 0)
        }
        .padding(.bottom, self.card.attendees.count > 5 ? 20 : 0)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(cardBackGround())
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .shadow(color: self.scheme == .dark ? Color(UIColor.systemGray6) : Color(UIColor.systemGray4), radius: 5, x: 0, y: 3)
    }
    
    private func mainTextColor() -> Color {
        if scheme == .light {
            return classic.primaryTextColor
        }
        else {
            return Color.white
        }
    }
    
    private func cardBackGround() -> some View {
        if scheme == .light {
            return Color(UIColor.systemBackground)
        }
        else {
            return Color(UIColor.systemGray6)
        }
        
    }

}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        CardItem(card: BillObject.sample[1])
            .previewDevice("iPhone 12")
    }
}
