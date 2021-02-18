//
//  mainView.swift
//  Dots
//
//  Created by Jack Zhao on 2/17/21.
//

import SwiftUI

struct mainView: View {
    @Binding var groups: [Int]
    @Binding var bills: [BillObject]
    
    // Bill Collection
    @State var editing: UUID? = nil

//    @State var draggingOffset: CGSize = .zero
//    @State var previousOffset: CGSize = .zero
    //    @State var opacity: Double = 0
    //    @State var beingDeleted: Bool = false
    //    @State var releaseToDelete: Bool = false
    
    // Bill transition
    @State var chosenBill: BillObject? = nil
    @State var fullView: Bool = false
    @State var isDisabled: Bool = false
    @State var zIndexPriority: BillObject? = nil
    
    @Namespace var namespace
    @State var animationDuration: Double = 0.3
//    @State var pressed: Bool = false
//    @State var pressingCard: BillObject? = nil
//    let pressScaleFactor: CGFloat = 0.95
    
    
    /// Home View
    var body: some View {
        ZStack {
            ScrollView (.vertical, showsIndicators: false) {
                HomeNavbarView(menuAction: {}, addAction: {})
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 270), spacing: 30)], spacing: 30) {
                    ForEach(self.bills) { bill in
                        CardRowView(bill: binding(for: bill), editing: $editing, namespace: namespace, activeBillDetail: activeBillDetail(bill:))
                        .matchedGeometryEffect(id: bill.id, in: namespace)
                        .frame(height: 130)
                    }
                }
                .padding()
            }

            // MARK: Bill detail view
            if self.fullView && self.chosenBill != nil {
                BillDetailView(chosenBill: binding(for: self.chosenBill!), namespace: namespace, dismissBillDetail: dismissBillDetail, animationDuration: self.animationDuration)
            }
        }
    }
    
    private func activeBillDetail(bill: BillObject) {
        withAnimation {
            fullView.toggle()
            chosenBill = bill
        }
        zIndexPriority = bill
        isDisabled = true
        haptic_one_click()
    }
    
    private func dismissBillDetail () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            isDisabled = false
            zIndexPriority = nil
        })
        fullView = false
        self.chosenBill = nil
    }
    
    private func addBill () {
        
    }
    

    
    private func binding(for bill: BillObject) -> Binding<BillObject> {
        guard let billIndex = bills.firstIndex(where: { $0.id == bill.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $bills[billIndex]
    }
    
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView(groups: .constant([1,2,3,4,5]), bills: .constant(BillObject.sample))
            .preferredColorScheme(.light)
            .previewDevice("iPhone 11")
    }
}
