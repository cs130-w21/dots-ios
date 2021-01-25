//
//  BillDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI

//struct BillDetailView: View {
//    @Binding var chosenBill: BillObject
//    @Binding var fullView: Bool
//    var namespace: Namespace.ID
//    let dismissBillDetail: () -> ()
//    var body: some View {
//        VStack {
//            CardView(cardObject: self.$chosenBill, currentSelected: chosenBill, paddingHorizontalValue: 0.1 * screen.width)
//                .matchedGeometryEffect(id: self.chosenBill.id, in: namespace, isSource: fullView)
//                .frame(maxWidth: 700, maxHeight: 0.25 * screen.height)
//                .zIndex(2.0)
//                .onTapGesture {
//                    withAnimation() {
//                        dismissBillDetail()
//                    }
//                }
//                .shadow(color: Color(UIColor.systemGray).opacity(0.3),radius: 15, x: 0, y: 10)
//                .ignoresSafeArea()
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 270), spacing: 20)], spacing: 25) {
//
//                    ForEach(self.chosenBill.entries) { entry in
//                        EntryView(entryInfo: entry)
//                            .frame(minHeight: 70)
//                            .padding(.horizontal)
//                            .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 3)
//                    }
//                }
//                .padding(.top, 50)
//                .padding(.horizontal)
//            }
//
//
//            .padding(.top, -20)
//        }
//        .ignoresSafeArea()
//        .frame(maxWidth: 650, maxHeight: 800)
//        .background(
//            ZStack {
//                BlurView(active: fullView, onTap: {
//                    withAnimation {
//                        dismissBillDetail()
//                    }
//                })
//                .cornerRadius(25)
//                .ignoresSafeArea()
//                .shadow(radius: 10, x: 5, y: 10)
//            }
//        )
        
//    }
//}

//struct BillDetailView_Preview: PreviewProvider {
//    static var previews: some View {
//        BillDetailView(chosenBill: .constant(.init()), fullView: .constant(true), dismissBillDetail: {})
//    }
//}
