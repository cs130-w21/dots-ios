//
//  BillDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct BillDetailView: View {
    @Binding var chosenBill: BillObject
//    @Binding var fullView: Bool
    var namespace: Namespace.ID
    let dismissBillDetail: () -> ()
    
    var body: some View {
        ZStack {
            BlurView(active: true, onTap: {})
//                .frame(minHeight: screen.height - 200)
//                .offset(y:200)
            ScrollView {
                CardItem(card: self.chosenBill)
                    .matchedGeometryEffect(id: self.chosenBill.id, in: namespace)
                    .frame(height: 250)
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 3)) {
                            dismissBillDetail()
                        }
                    }
                    
                    EntryListView(bill: self.$chosenBill)
                
            }
        }
        .transition(.asymmetric(insertion: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(3)), removal: AnyTransition
                                        .opacity
                                        .animation(Animation.spring().delay(0))))
        .edgesIgnoringSafeArea(.all)
    }

}

struct BillDetailView_Preview: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        BillDetailView(chosenBill: .constant(BillObject.sample[1]), namespace: namespace, dismissBillDetail: {})
    }
}
