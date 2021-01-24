////
////  CardModalView.swift
////  Dots
////
////  Created by Jack Zhao on 1/22/21.
////
//
//import SwiftUI
//
//struct CardModalView: View {
//    @Binding var inGroup: [Int]
//    @Binding var bills: [BillObject]
//    @Binding var cardObject: BillObject
//    
//    // Local variables
//    @State var showDetail: Bool = false
//    @State var tapped: Bool = false
//    @Namespace var namespace
//    
//    
//    var body: some View {
//        ZStack {
//            //            BlurView(active: showDetail, onTap: {})
//            //                .ignoresSafeArea()
//            if showDetail {
//                ScrollView {
//                    VStack (spacing: 20){
//                        ForEach(0 ..< 20) { i in
//                            RoundedRectangle(cornerRadius: 25.0)
//                                .frame(height: 60)
//                                .foregroundColor(Color(UIColor.systemGray5))
//                        }
//                    }
//                    .offset(y: 220)
//                    .padding(.top, 40)
//                    .padding(.horizontal, 30)
//                    
//                }
//                .frame(maxWidth: 400)
//                .transition(.asymmetric(
//                                insertion: AnyTransition
//                                    .opacity
//                                    .animation(Animation.spring().delay(0.3)),
//                                removal: AnyTransition
//                                    .opacity
//                                    .animation(Animation.spring().delay(0))))
//                VStack {
//                    CardView(cardObject: self.$cardObject)
//                        .matchedGeometryEffect(id: cardObject.id, in: namespace, isSource: self.showDetail)
//                        .frame(maxHeight: 220)
//                        .shadow(color: Color(UIColor.systemGray4).opacity(0.5),radius: 8, x: 0, y: 5)
//                        .onTapGesture {
//                            withAnimation {
//                                self.showDetail.toggle()
//                            }
//                        }
//                    Spacer()
//                }
//                
//            } else {
//                CardView(cardObject: self.$cardObject)
//                    .matchedGeometryEffect(id: cardObject.id, in: namespace, isSource: !self.showDetail)
//                    .frame(maxHeight: 180)
//                    .padding(.horizontal)
//                    .shadow(color: Color(UIColor.systemGray4).opacity(0.9),radius: 8, x: 0, y: 5)
//                    .onTapGesture {
//                        withAnimation {
//                            self.showDetail.toggle()
//                        }
//                    }
//            }
//        }
//        .ignoresSafeArea()
//    }
//}
//
//
//
//
////
////struct CardModalView_Previews: PreviewProvider {
////    static var previews: some View {
////        CardView(cardObject: .constant(BillObject.sample[2]))
////        CardModalView(cardObject: .constant(BillObject.sample[2]))
////            .preferredColorScheme(.light)
////    }
////}
