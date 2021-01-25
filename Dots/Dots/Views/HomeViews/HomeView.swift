//
//  HomeView.swift
//  Dots
//
//  Created by Jack Zhao on 1/11/21.
//

import SwiftUI

struct HomeView: View {
    @Binding var groups: [Int]
    @Binding var bills: [BillObject]
    
    @State var showDots: Bool = false
    @State var chosenBill: BillObject? = nil
    
    @State var fullView: Bool = false
    @State var isDisabled: Bool = false
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            // MARK: Background Color
            Color(UIColor.systemGray6)
                .ignoresSafeArea(edges: [.top, .bottom])
            // MARK: Main View
            ScrollView (.vertical, showsIndicators: false) {
                TitleComponent()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 280), spacing: 20)], spacing: 25) {
                    ForEach(self.bills) { bill in
                        CardView(cardObject: binding(for: bill))
                            .matchedGeometryEffect(id: bill.id, in: namespace, isSource: self.chosenBill == nil)
                            .frame(minHeight: 150)
                            .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 10)
                            .onTapGesture {
                                withAnimation() {
                                    fullView.toggle()
                                    self.chosenBill = bill
                                    isDisabled = true
                                }
                            }
                            .disabled(isDisabled)
                    }
                }
//                .padding(.top, 130)
                .padding(.bottom, 150)
                .padding(.horizontal)
                
            }
            // MARK: Title View
            HomeTitleView()
                .opacity(fullView ? 0 : 1)
            // MARK: Bottom View
            GeneralBottomView(buttonText: "+ Add Bill", alternativeText: "show paid bills", confirmFunc: self.addBill, alternativeFunc: self.completeBillToggle)
                .opacity(fullView ? 0.2 : 1)
            
            if self.chosenBill != nil {
                BillDetailView(chosenBill: binding(for: self.chosenBill!), fullView: self.$fullView, namespace: self.namespace, dismissBillDetail: dismissBillDetail)
            }
        }
    }
    
    private func dismissBillDetail () {
        fullView.toggle()
        self.chosenBill = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            isDisabled = false
        })
    }
    
    private func addBill () {
        
    }
    
    private func completeBillToggle() {
        
    }
    
    private func binding(for bill: BillObject) -> Binding<BillObject> {
        guard let billIndex = bills.firstIndex(where: { $0.id == bill.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $bills[billIndex]
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(groups: .constant([1,2,3,4,5]), bills: .constant(BillObject.sample), showDots: false)
            .previewDevice("iPhone 12")
    }
}




