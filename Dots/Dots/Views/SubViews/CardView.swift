////
////  SingleCard.swift
////  Dots
////
////  Created by Guanqun Ma on 1/10/21.
////
//
//import SwiftUI
//import UIKit
//
//struct CardView: View {
//    //    @Binding var cardObject: BillObject
//    //    let currentSelected: BillObject?
//    //    let paddingHorizontalValue: CGFloat
//    //    private let cardBackgroundColor = LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray5), Color(UIColor.systemBackground)]), startPoint: .bottom, endPoint: .top)
//    
//    @Binding var card: BillObject
//    @State var showDetail: Bool = false
//    @Namespace var namespace
//    @Environment(\.colorScheme) var scheme
//    var body: some View {
//        ZStack {
//            CardItem(card: card)
//                .matchedGeometryEffect(id: "card", in: namespace, isSource: !showDetail)
//                .frame(width: 300, height: 180)
//                .onTapGesture {
//                    withAnimation(.easeOut(duration: 3)) {
//                        showDetail.toggle()
//                    }
//                }
//            VStack {
//                if showDetail {
//                    ScrollView {
//                        CardItem(card: card)
//                            .matchedGeometryEffect(id: "card", in: namespace)
//                            .frame(height: 250)
//                            .onTapGesture {
//                                withAnimation(.spring()) {
//                                    showDetail.toggle()
//                                }
//                            }
//                        VStack {
//                            ForEach(self.card.entries) { entry in
//                                EntryView(entryInfo: entry)
//                            }
//                        }
//                        .padding()
//                    }
//                    .background(BlurView(active: showDetail, onTap: {}))
//                    .transition(.asymmetric(insertion: AnyTransition
//                                                .opacity
//                                                .animation(Animation.spring().delay(3)), removal: AnyTransition
//                                                    .opacity
//                                                    .animation(Animation.spring().delay(0))))
//                    .edgesIgnoringSafeArea(.all)
//                }
//            }
//        } 
//    }
//}
//struct SingleCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: .constant(BillObject.sample[0]))
//            .previewLayout(.sizeThatFits)
//        //            .padding()
//    }
//}
