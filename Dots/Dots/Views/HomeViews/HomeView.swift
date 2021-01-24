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
                .ignoresSafeArea()
            // MARK: Main View
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 280), spacing: 20)], spacing: 25) {
                    ForEach(self.bills) { bill in
                        CardView(cardObject: binding(for: bill))
                            .matchedGeometryEffect(id: bill.id, in: namespace, isSource: !fullView)
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
                .padding(.top, 130)
                .padding(.bottom, 140)
                .padding(.horizontal)
                
            }
            // MARK: Title View
            HomeTitleView()
                .opacity(fullView ? 0 : 1)
            // MARK: Bottom View
            HomeBottomView(addBillFunc: self.addBill, completeBillFunc: self.completeBillToggle)
            
            if self.chosenBill != nil {
                VStack {
                    CardView(cardObject: binding(for: self.chosenBill!))
                        .matchedGeometryEffect(id: self.chosenBill!.id, in: namespace)
                        .frame(height: 0.25 * screen.height)
                        .zIndex(1.0)
                        .onTapGesture {
                            withAnimation() {
                                dismissBillDetail()
                            }
                        }
                    ScrollView {
                        VStack (spacing: 15) {
                            ForEach(self.chosenBill!.entries) { entry in
                                EntryView(entryInfo: entry)
                                    .frame(minHeight: 70)
                                    .padding(.horizontal)
                                    .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 3)
                            }
                        }
                        .padding(.top, 50)
                        .padding(.horizontal)
                    }
                    .padding(.top, -30)
                }
                .ignoresSafeArea()
                .background(BlurView(active: fullView, onTap: dismissBillDetail))
                .transition(.asymmetric(
                                insertion: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(0.3)),
                                removal: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(0))))
            }
            
            
        }
        
        //        ZStack {
        //            ScrollView (.vertical, showsIndicators: false) {
        //                DotSelectView(show: $showDots, circleRadius: 110, inGroup: $groups, allDots: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        //                        .padding(.vertical)
        //                        .opacity(fullView ? 0 : 1)
        //
        //
        //                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 280), spacing: 20)], spacing: 25) {
        //
        //                        ForEach(bills) { i in
        //                            CardView(card: binding(for: i))
        //                                .frame(minHeight: 180)
        //                                .background(dotColors[i.initiator])
        //                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        //                                .shadow(color: dotColors[i.initiator].opacity(0.5),radius: 10, x: 0, y: 5)
        //                                .matchedGeometryEffect(id: i.id, in: namespace, isSource: selected == nil)
        //                            CardModalView(cardObject: binding(for: i))
        //                                .frame(minHeight: 180)
        
        //                                .onTapGesture {
        //                                    withAnimation() {
        //                                        fullView.toggle()
        //                                        selected = i
        //                                        isDisabled = true
        //                                    }
        //                                }
        //                                .disabled(isDisabled)
        //                                .zIndex(0)
        //                        }
        //
        //                    }
        ////                    .blur(radius: showDots ? 10 : 0)
        ////                    .padding(.horizontal, 30)
        ////                    .padding(.bottom, 100)
        //            }
        ////
        ////            if selected != nil {
        ////                ZStack {
        ////                    BlurView(active: true, onTap: {})
        ////                        .ignoresSafeArea()
        ////
        ////                    ScrollView {
        ////                        CardView(card: binding(for: selected!))
        ////
        ////                            .frame(height: 280)
        ////                            .background(dotColors[selected!.initiator])
        ////                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        ////                            .shadow(color: dotColors[selected!.initiator].opacity(0.5),radius: 10, x: 0, y: 5)
        ////    //                        .padding(.top)
        ////                            .matchedGeometryEffect(id: selected!.id, in: namespace)
        ////                            .onTapGesture {
        ////                                withAnimation() {
        ////                                    fullView.toggle()
        ////                                    selected = nil
        ////                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
        ////                                        isDisabled = false
        ////                                    })
        ////
        ////                                }
        ////                            }
        ////                        VStack (alignment: .leading) {
        ////                            ForEach(self.selected!.entries) { entry in
        ////                                Text("\(entry.entryTitle), amount: \(entry.value)")
        ////                                    .padding()
        ////                            }
        ////                        }
        ////                        .padding(.top)
        ////
        ////                    }
        ////                    .ignoresSafeArea(edges: .top)
        ////                }
        ////                .transition(.asymmetric(
        ////                                insertion: AnyTransition
        ////                                    .opacity
        ////                                    .animation(Animation.spring().delay(0.3)),
        ////                                removal: AnyTransition
        ////                                    .opacity
        ////                                    .animation(Animation.spring().delay(0))))
        ////            }
        //        }
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


