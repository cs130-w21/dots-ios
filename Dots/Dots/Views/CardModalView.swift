//
//  CardModalView.swift
//  Dots
//
//  Created by Jack Zhao on 1/22/21.
//

import SwiftUI

struct CardModalView: View {
    @Binding var cardObject: BillObject
    
    // Local variables
    @State var showDetail: Bool = false
    @Namespace var namespace
    private let cardBackgroundColor = LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray5), Color(UIColor.systemBackground)]), startPoint: .bottom, endPoint: .top)
    
    var body: some View {
        ZStack {
            if showDetail {
                
            } else {
                VStack {
                    Spacer()
                    HStack {
                        VStack (alignment: .leading, spacing: 0) {
                            Text(self.cardObject.getDate())
                                .foregroundColor(Color.gray)
                                .font(.system(.callout, design: .rounded))
                            Text(self.cardObject.title)
                                .font(.system(.title, design: .rounded))
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
                    Spacer()
                }
            }
        }
        .padding()
        .background(self.cardBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .shadow(color: Color(UIColor.systemGray4).opacity(0.9),radius: 8, x: 0, y: 5)
    }
}

struct CardModalView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack (spacing: 30){
            CardModalView(cardObject: .constant(BillObject.sample[2]))
                .previewLayout(.sizeThatFits)
                .frame(maxHeight: 180)
                CardModalView(cardObject: .constant(BillObject.sample[1]))
                    .previewLayout(.sizeThatFits)
                    .frame(maxHeight: 180)
            }
        }
    }
}
