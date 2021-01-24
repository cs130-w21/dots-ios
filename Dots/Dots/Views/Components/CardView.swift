//
//  SingleCard.swift
//  Dots
//
//  Created by Guanqun Ma on 1/10/21.
//

import SwiftUI
import UIKit

struct CardView: View {
    @Binding var cardObject: BillObject
    
    private let cardBackgroundColor = LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray5), Color(UIColor.systemBackground)]), startPoint: .bottom, endPoint: .top)
    
    var body: some View {
        VStack {
            Spacer()
            // MARK: Card mid content
            HStack {
                VStack (alignment: .leading, spacing: 0) {
                    Text(self.cardObject.getDate())
                        .foregroundColor(Color.gray)
                        .font(.system(.caption, design: .rounded))
                    Text(self.cardObject.title)
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(classic.primaryTextColor)
                    
                }
                Spacer()
                // MARK: Total
                ZStack (alignment: .trailing) {
                    Text("$ \(self.cardObject.billAmount, specifier: "%.2f")")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(classic.primaryTextColor)
                    
                    // MARK: Dots
                    VStack {
                        if self.cardObject.attendees.count > 5 {
                            
                            VStack (alignment: .trailing) {
                                HStack (spacing: 5) {
                                    ForEach(0 ..< 5) { index in
                                        // TODO: Replace circle view
                                        CircleView(index: index, diameter: 15, hasRing: false, ringStroke: 0)
                                    }
                                }
                                HStack (spacing: 5) {
                                    ForEach(5 ..< self.cardObject.attendees.count) { index in
                                        // TODO: Replace circle view
                                        CircleView(index: index, diameter: 15, hasRing: false, ringStroke: 0)
                                    }
                                }
                            }
                        }
                        else {
                            HStack (spacing: 5) {
                                ForEach(0 ..< self.cardObject.attendees.count) { index in
                                    // TODO: Replace circle view
                                    CircleView(index: index, diameter: 15, hasRing: false, ringStroke: 0)
                                }
                            }
                        }
                    }
                    .offset(y: self.cardObject.attendees.count > 5 ? 40 : 28)
                }
                
            }
            .padding(.bottom, self.cardObject.attendees.count > 5 ? 20 : 10)
            Spacer()
        }
        .padding()
        .background(self.cardBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        //        .background(Color.black.opacity(0.001))
        
    }
}
struct SingleCard_Previews: PreviewProvider {
    static var previews: some View {
        CardView(cardObject: .constant(BillObject.sample[0]))
            .previewLayout(.sizeThatFits)
    }
}
