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
    @State var activateFullBlur = false
    var body: some View {
        
        ScrollView {
            CardItem(card: self.chosenBill)
                .matchedGeometryEffect(id: self.chosenBill.id, in: namespace)
                .frame(height: 250)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        dismissBillDetail()
                    }
                }
            EntryListView(bill: self.$chosenBill)
        }
        .background(BlurView(active: true, onTap: {})
                        .offset(y: activateFullBlur ? 0 : 200))
        .transition(.asymmetric(insertion: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(0.4)), removal: AnyTransition
                                        .opacity
                                        .animation(Animation.spring().delay(0))))
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                withAnimation {
                activateFullBlur = true
                }
            })
        })
        .onDisappear(perform: {
            withAnimation {
            activateFullBlur = false
            }
        })
        
        
        .edgesIgnoringSafeArea(.vertical)
    }
    
}

struct BillDetailView_Preview: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        BillDetailView(chosenBill: .constant(BillObject.sample[1]), namespace: namespace, dismissBillDetail: {})
    }
}
