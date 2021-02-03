//
//  BillDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

struct BillDetailView: View {
    
    @Binding var chosenBill: BillObject
    var namespace: Namespace.ID
    let dismissBillDetail: () -> ()
    let animationDuration: Double
    
    @State var activateFullBlur = false
    @State var selectedEntry: EntryObject = .init()
    @State var showEntry: Bool = false
    //    @State var isDisabled: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView (.vertical, showsIndicators: false) {
                CardItem(card: self.chosenBill)
                    .matchedGeometryEffect(id: self.chosenBill.id, in: namespace)
                    .frame(height: 200)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: animationDuration+0.1)) {
                            dismissBillDetail()
                        }
                    }
                EntryListView(bill: self.$chosenBill, selectedEntry: self.$selectedEntry, show: self.$showEntry)
            }
            .background(BlurBackgroundView(style: .systemChromeMaterialLight))
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration, execute: {
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
            VStack {
                Spacer()
            
                EntryDetailView(parentBill: self.$chosenBill, target: self.$selectedEntry, show: self.$showEntry)
                .offset(y: showEntry ? 0 : 800)
                if !showEntry {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showEntry = true
                            }
                        }) {
                            Circle()
                                .frame(width: 80, height: 80)
                        }
                        .padding(.bottom)
                        .padding(.trailing)
                    }
                }
            }
        }
        .transition(.asymmetric(insertion: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(animationDuration)), removal: AnyTransition
                                        .opacity
                                        .animation(Animation.spring().delay(0))))
        
        .edgesIgnoringSafeArea(.vertical)
    }
}

struct BillDetailView_Preview: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        BillDetailView(chosenBill: .constant(BillObject.sample[1]), namespace: namespace, dismissBillDetail: {}, animationDuration: 0.3, selectedEntry: .init())
            .preferredColorScheme(.dark)
    }
}
