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
    @State var zIndexPriority: BillObject? = nil
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            // MARK: Background Color
            Color(UIColor.systemBackground)
                .ignoresSafeArea(edges: [.top, .bottom])
            // MARK: Main View
            VStack {
                ScrollView (.vertical, showsIndicators: false) {
                    HomeNavbarView(activeBillNumber: self.bills.count, menuAction: {})
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 270), spacing: 30)], spacing: 40) {
                        ForEach(self.bills) { bill in
                            CardView(cardObject: binding(for: bill), currentSelected: self.chosenBill, paddingHorizontalValue: 20)
                                .frame(minHeight: 150)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                .matchedGeometryEffect(id: bill.id, in: namespace)
                                .onTapGesture {
                                    withAnimation() {
                                        fullView.toggle()
                                        self.chosenBill = bill
                                        zIndexPriority = bill
                                        isDisabled = true
                                    }
                                }
                                
                                .zIndex(zIndexPriority == nil ? 0 : (zIndexPriority == bill ? 1 : 0))
                                .disabled(isDisabled)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 150)
                    .padding(.horizontal, 25)
                }
            }
            
            // MARK: Title View
            TopEdgeBlur()
            
            // MARK: Bottom View
            GeneralBottomView(buttonText: "+ Add Bill", alternativeText: "show paid bills", confirmFunc: self.addBill, alternativeFunc: self.completeBillToggle)
                .opacity(fullView ? 0.2 : 1)
                .shadow(color: Color(UIColor.systemGray).opacity(0.3),radius: 10, x:0, y: -10)
            
            
            VStack {
                if self.chosenBill != nil {
                    CardView(cardObject: binding(for: chosenBill!), currentSelected: chosenBill, paddingHorizontalValue: 0.1 * screen.width)
                        .ignoresSafeArea()
                        .frame(maxWidth: 700, maxHeight: 0.25 * screen.height)
                        .shadow(color: Color(UIColor.systemGray).opacity(0.3),radius: 15, x: 0, y: 10)
                        .onTapGesture {
                            withAnimation() {
                                dismissBillDetail()
                            }
                        }
                        .matchedGeometryEffect(id: self.chosenBill!.id, in: namespace)
                        .transition(.identity)
                        
//                    ScrollView {
//                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 270), spacing: 20)], spacing: 25) {
//
//                            ForEach(self.chosenBill!.entries) { entry in
//                                EntryView(entryInfo: entry)
//                                    .frame(minHeight: 70)
//                                    .padding(.horizontal)
//                                    .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 3)
//                            }
//                        }
//                        .padding(.top, 50)
//                        .padding(.horizontal)
//                    }
//                    .transition(.asymmetric(
//                                    insertion: AnyTransition
//                                        .opacity
//                                        .animation(Animation.easeOut.delay(0.3)),
//                                    removal: AnyTransition
//                                        .opacity
//                                        .animation(Animation.easeOut)))
//
//                    .padding(.top, -20)
                }
            }
            .animation(.easeIn(duration: 2))
//            .ignoresSafeArea()
            .frame(maxWidth: 650, maxHeight: 800)
//            .background(
//                ZStack {
//                    BlurView(active: fullView, onTap: {
//                        withAnimation {
//                            dismissBillDetail()
//                        }
//                    })
//                    .cornerRadius(25)
//                    .ignoresSafeArea()
//                    .shadow(radius: 10, x: 5, y: 10)
//                }
//            )
   
        }
    }
    
    private func dismissBillDetail () {
        fullView.toggle()
        self.chosenBill = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            isDisabled = false
            zIndexPriority = nil
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
            .previewDevice("iPhone 11")
    }
}




