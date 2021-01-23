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
    @State var tapped: Bool = false
    @Namespace var namespace
    
    
    var body: some View {
        ZStack {
            //            BlurView(active: showDetail, onTap: {})
            //                .ignoresSafeArea()
            if showDetail {
                ScrollView {
                    VStack (spacing: 20){
                        ForEach(0 ..< 20) { i in
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(height: 60)
                                .foregroundColor(Color(UIColor.systemGray5))
                        }
                    }
                    .offset(y: 220)
                    .padding(.top, 40)
                    .padding(.horizontal, 30)
                    
                }
                .frame(maxWidth: 400)
                .transition(.asymmetric(
                                insertion: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(0.3)),
                                removal: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(0))))
                VStack {
                    CardObjectView(cardObject: self.$cardObject)
                        .matchedGeometryEffect(id: cardObject.id, in: namespace, isSource: self.showDetail)
                        .frame(maxHeight: 220)
                        .shadow(color: Color(UIColor.systemGray4).opacity(0.5),radius: 8, x: 0, y: 5)
                        .onTapGesture {
                            withAnimation {
                                self.showDetail.toggle()
                            }
                        }
                    Spacer()
                }
                
                
                
            } else {
                CardObjectView(cardObject: self.$cardObject)
                    .matchedGeometryEffect(id: cardObject.id, in: namespace, isSource: !self.showDetail)
                    .frame(maxHeight: 180)
                    .shadow(color: Color(UIColor.systemGray4).opacity(0.9),radius: 8, x: 0, y: 5)
                    .onTapGesture {
                        withAnimation {
                            self.showDetail.toggle()
                        }
                    }
            }
        }
        
        .ignoresSafeArea()
        
        
        
    }
}

struct CardModalView_Previews: PreviewProvider {
    static var previews: some View {
        CardModalView(cardObject: .constant(BillObject.sample[2]))
            .preferredColorScheme(.light)
    }
}


struct CardObjectView: View {
    @Binding var cardObject: BillObject
    
    private let cardBackgroundColor = LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray5), Color(UIColor.systemBackground)]), startPoint: .bottom, endPoint: .top)
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                // MARK: Card mid content
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
            .padding()
        }
        .background(self.cardBackgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        //        .background(Color.black.opacity(0.001))
        
        
        
    }
}
