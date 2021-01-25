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
                .matchedGeometryEffect(id: self.chosenBill.id, in: namespace, isSource: fullView)
                .frame(maxWidth: 500, maxHeight: 0.25 * screen.height)
                .zIndex(2.0)
                .onTapGesture {
                    withAnimation() {
                        dismissBillDetail()
                    }
                }
                .shadow(color: Color(UIColor.systemGray).opacity(0.3),radius: 15, x: 0, y: 10)
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 270), spacing: 20)], spacing: 25) {
                
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
            .onTapGesture {
                withAnimation() {
                    dismissBillDetail()
                }
            }
            
            .padding(.top, -20)
        }
        .ignoresSafeArea()
        .background(BlurView(active: fullView, onTap: {
            withAnimation {
                dismissBillDetail()
            }
        }))
        .transition(.asymmetric(
                        insertion: AnyTransition
                            .opacity
                            .animation(Animation.spring().delay(0.3)),
                        removal: AnyTransition
                            .opacity
                            .animation(Animation.spring())))
    }
}

//struct BillDetailView_Preview: PreviewProvider {
//    static var previews: some View {
//        BillDetailView(chosenBill: .constant(.init()), fullView: .constant(true), dismissBillDetail: {})
//    }
//}
