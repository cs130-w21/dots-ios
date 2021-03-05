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
    
    /// Corner radius of the card.
    var cornerRadius: CGFloat = 25.0
    /// Define minimum scale coefficient that the text size can shrink.
    let minScaleFactor: CGFloat = 0.5
    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
    
    /// A namespace that contains all the animatable objects during transition.
    @Namespace var cardModal
    
    /// Card iterm body view.
    var body: some View {
        GeometryReader { geo in
            if geo.size.width < 230 {
                HStack (alignment: .center) {
                    Spacer()
                        VStack (alignment: .center, spacing: 4) {
                            Text(self.card.getDate())
                                .matchedGeometryEffect(id: self.card.getDate(), in: self.cardModal)
                                .foregroundColor(self.card.paid ? mainTextColor() : Color.gray)
                                .font(.system(.caption2, design: .rounded))
                            HStack {
                                Text(self.card.title)
                                    .font(.system(.callout, design: .rounded))
                                    .fontWeight(.semibold)
                                    .foregroundColor(mainTextColor())
                                    .minimumScaleFactor(minScaleFactor)
                                    .lineLimit(2)
                                    .matchedGeometryEffect(id: self.card.title, in: self.cardModal)
                                if card.paid {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color(UIColor.gray))
                                }
                            }
                            Text("$ \(self.card.getBillTotal(), specifier: "%.2f")")
                                .font(.system(.callout, design: .rounded))
                                .fontWeight(.semibold)
                                .foregroundColor(mainTextColor())
                                .minimumScaleFactor(minScaleFactor)
                                .lineLimit(2)
                                .matchedGeometryEffect(id: self.card.getBillTotal(), in: self.cardModal)
                        }
                    
                    Spacer()
                }.frame(height: geo.size.height)
            } else {
                    HStack {
                        VStack (alignment: .leading) {
                            Text(self.card.getDate())
                                .matchedGeometryEffect(id: self.card.getDate(), in: self.cardModal)
                                .foregroundColor(self.card.paid ? mainTextColor() : Color.gray)
                                .font(.system(.caption, design: .rounded))
                            HStack {
                                Text(self.card.title)
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.semibold)
                                    .foregroundColor(mainTextColor())
                                    .matchedGeometryEffect(id: self.card.title, in: self.cardModal)
                                    .minimumScaleFactor(minScaleFactor)
                                    .lineLimit(1)
                                if card.paid {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color(UIColor.gray))
                                }
                            }
                        }
                        Spacer()
                        VStack (alignment: .trailing, spacing: 0){
                                Text("$ \(self.card.getBillTotal(), specifier: "%.2f")")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.semibold)
                                    .foregroundColor(mainTextColor())
                                    .matchedGeometryEffect(id: self.card.getBillTotal(), in: self.cardModal)
                                    .minimumScaleFactor(minScaleFactor)
                                    .lineLimit(1)
                                // MARK: Dots
                                VStack  {
                                    if self.card.attendees.count > 5 {
                                        VStack (alignment: .trailing) {
                                            HStack (spacing: 5) {
                                                CircleView(index: self.card.initiator, diameter: 25)
                                                    .overlay(Image(systemName: "person.fill")
                                                                .foregroundColor(Color(UIColor.systemBackground)))
                                                ForEach(0 ..< 4, id: \.self) { index in
                                                    // TODO: Replace circle view
                                                    if self.card.attendees[index] !=  self.card.initiator {
                                                        CircleView(index: self.card.attendees[index], diameter: 15, hasRing: false, ringStroke: 0)
                                                    }
                                                }
                                            }
                                            HStack (spacing: 5) {
                                                ForEach(4 ..< self.card.attendees.count, id: \.self) { index in
                                                    // TODO: Replace circle view
                                                    if self.card.attendees[index] !=  self.card.initiator {
                                                        CircleView(index: self.card.attendees[index], diameter: 15, hasRing: false, ringStroke: 0)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        HStack (spacing: 5) {
                                            CircleView(index: self.card.initiator, diameter: 25)
                                                .overlay(Image(systemName: "person.fill")
                                                            .foregroundColor(Color(UIColor.systemBackground)))
                                            ForEach(self.card.attendees, id: \.self) { index in
                                                // TODO: Replace circle view
                                                if index != self.card.initiator {
                                                    CircleView(index: index, diameter: 15, hasRing: false, ringStroke: 0)
                                                }
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
                    .frame(height: geo.size.height)
            }
        }
        .opacity(card.paid ? 0.3 : 1)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(cardBackGround())
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
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
