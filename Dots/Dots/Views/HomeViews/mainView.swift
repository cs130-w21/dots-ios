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
    @State var rowOffset: CGSize = .zero
    let buttonWidth: CGFloat = 90
    let gap: CGFloat = 10
    @State var draggingOffset: CGSize = .zero
    @State var previousOffset: CGSize = .zero
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
    @State var pressed: Bool = false
    @State var pressingCard: BillObject? = nil
    let pressScaleFactor: CGFloat = 0.95
    
    
    /// Home View
    var body: some View {
        ZStack {
            
            ScrollView (.vertical, showsIndicators: false) {
                HomeNavbarView(menuAction: {}, addAction: {})
                LazyVGrid (columns: [GridItem(.adaptive(minimum: 270), spacing: 30)], spacing: 30) {
                    ForEach(self.bills) { bill in
                        GeometryReader { geo in
                            HStack (spacing: gap) {
                                CardItem(card: bill)
                                    .matchedGeometryEffect(id: bill.id, in: namespace)
                                    .scaleEffect(self.pressed && self.pressingCard == bill ? self.pressScaleFactor : 1)
                                    .frame(width: geo.size.width)
                                
                                Button(action: {}) {
                                    ZStack {
                                        Image(systemName: "checkmark.seal")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: editing == bill.id ? (
                                            self.draggingOffset.width < 0 ?
                                                (-0.5 * (self.draggingOffset.width + gap) > 0 ? -0.5 * (self.draggingOffset.width + gap) : 0) : 0) : 0, height: geo.size.height)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .shadow(color: Color.blue.opacity(0.4), radius: 5, x: 0, y: 3)
                                }
                                
                                Button(action: {}) {
                                    ZStack {
                                        Image(systemName: "trash")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: editing == bill.id ? (
                                            self.draggingOffset.width < 0 ?
                                                (-0.5 * (self.draggingOffset.width + 2 * gap) > 0 ? -0.5 * (self.draggingOffset.width + 2 * gap) : 0) : 0) : 0, height: geo.size.height)
                                    .background(Color.red)
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    .shadow(color: Color.red.opacity(0.4), radius: 5, x: 0, y: 3)
                                }
                            }
                            .offset(x: editing == bill.id ? self.draggingOffset.width : 0, y: 0)
                            .animation(.easeOut)
                            .gesture(DragGesture()
                                        .onChanged { gesture in
                                            if (gesture.translation.width + previousOffset.width <= 0) {
                                                self.draggingOffset.width = gesture.translation.width + previousOffset.width
                                            }
                                            if editing != bill.id {
                                                self.draggingOffset = .zero
                                                self.previousOffset = .zero
                                                editing = bill.id
                                            }
                                        }
                                        .onEnded { gesture in
                                            if gesture.translation.width > 0 {
                                                editing = nil
                                            } else {
                                                if self.draggingOffset.width < -35 {
                                                    self.draggingOffset.width = -(2 * self.buttonWidth + 2 * gap)
                                                    self.previousOffset.width = self.draggingOffset.width
                                                    editing = bill.id
                                                } else {
                                                    self.draggingOffset = .zero
                                                    self.previousOffset = .zero
                                                    editing = nil
                                                }
                                            }
                                            
                                        })
                            .onTapGesture {
                                if self.editing != nil {
                                    self.editing = nil
                                } else {
                                    activeBillDetail(bill: bill)
                                }
                            }
                            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity,
                                                pressing: { pressing in
                                                    withAnimation(.easeInOut(duration: 0.2)) {
                                                        self.pressed = pressing
                                                        self.pressingCard = bill
                                                    }
                                                }, perform: { self.pressingCard = nil })
                        }
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
