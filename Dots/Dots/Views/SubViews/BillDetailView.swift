//
//  BillDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct BillDetailView: View {
    @Binding var chosenBill: BillObject
    @Binding var fullView: Bool
    var namespace: Namespace.ID
    let dismissBillDetail: () -> ()
    var body: some View {
        VStack {
            CardView(cardObject: self.$chosenBill)
                
                //                .animation(.easeIn(duration: 3))
                .matchedGeometryEffect(id: self.chosenBill.id, in: namespace, isSource: fullView)
                .frame(maxHeight: 0.25 * screen.height)
                .zIndex(1.0)
                .onTapGesture {
                    withAnimation() {
                        dismissBillDetail()
                    }
                }
                .ignoresSafeArea()
            ScrollView {
                VStack (spacing: 15) {
                    ForEach(self.chosenBill.entries) { entry in
                        EntryView(entryInfo: entry)
                            .frame(minHeight: 70)
                            .padding(.horizontal)
                            .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 3)
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal)
            }
            
            .background(BlurView(active: fullView, onTap: {}))
            .padding(.top, -30)
        }
        .ignoresSafeArea()
        .transition(.asymmetric(
                        insertion: AnyTransition
                            .opacity
                            .animation(Animation.easeIn(duration: 0.3).delay(0.3)),
                        removal: AnyTransition
                            .opacity
                            .animation(Animation.easeIn(duration: 0.3).delay(0))))
        
        
                
        
    }
}

//struct BillDetailView_Preview: PreviewProvider {
//    static var previews: some View {
//        BillDetailView(chosenBill: .constant(.init()), fullView: .constant(true), dismissBillDetail: {})
//    }
//}
