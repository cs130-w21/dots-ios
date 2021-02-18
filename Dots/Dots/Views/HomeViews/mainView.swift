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
    
    /// Stores the UUID of current bill that is being edited.
    @State var editing: UUID? = nil
    
    
    // Bill transition
    
    /// Stores the information of the selected bill
    @State var chosenBill: BillObject? = nil
    
    /// This value is true when `BillDetailView` is active
    @State var fullView: Bool = false
    
    /// Disable other card views from gesture control when one card is animating
    @State var isDisabled: Bool = false
    
    /// Stores the bill whose Z Index must be prioritized to prevent overlapped by other card views. Usually the selected bill.
    @State var zIndexPriority: BillObject? = nil
    
    /// <#Description#>
    @Namespace var namespace
    
    /// <#Description#>
    @State var animationDuration: Double = 0.3
    
    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
    
    /// Home View
    var body: some View {
        ZStack {
            primaryBackgroundColor()
                .ignoresSafeArea()
            
            
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
            
            HomeBottomView(buttonText: "Calculate", confirmFunc: {}, backgroundColor: primaryBackgroundColor())

            // MARK: Bill detail view
            if self.fullView && self.chosenBill != nil {
                BillDetailView(chosenBill: binding(for: self.chosenBill!), namespace: namespace, dismissBillDetail: dismissBillDetail, animationDuration: self.animationDuration)
            }
        }
    }
    
    
    
    
    private func primaryBackgroundColor() -> Color {
        if scheme == .dark {
            return Color.black
        }
        else {
            return Color(UIColor(rgb: 0xFCFCFF))
        }
    }
    
    /// A series of actions to active a `BillDetailView`
    /// - Parameter bill: target bill object.
    private func activeBillDetail(bill: BillObject) {
        withAnimation {
            fullView.toggle()
            chosenBill = bill
        }
        zIndexPriority = bill
        isDisabled = true
        haptic_one_click()
    }
    
    /// A series of actions when the `BillDetailView` is deactivated
    private func dismissBillDetail () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            isDisabled = false
            zIndexPriority = nil
        })
        fullView = false
        self.chosenBill = nil
    }
    
    /// Add a bill
    private func addBill () {
        
    }
    
    
    /// A manual binding function. Often used in `ForEach` loop.
    /// - Parameter bill: `BillObjet` that cannot use binding naturally.
    /// - Returns: A binding object of the bill
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
