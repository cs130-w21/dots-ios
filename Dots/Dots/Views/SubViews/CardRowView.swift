//
//  CardRowView.swift
//  Dots
//
//  Created by Jack Zhao on 2/18/21.
//

import SwiftUI

/// Card row view.
struct CardRowView: View {
    /// An instance of Billobjests.
    var bill: BillObject
    @Binding var editing: UUID?
    /// Namespace.
    var namespace: Namespace.ID
    /// Active bill detail action function.
    var activeBillDetail: () -> ()
    /// Delete action function.
    var deleteAction: () -> ()
    /// Secondary action function.
    var secondaryAction: () -> ()
    
    /// Initialize offset for dragging.
    @State var draggingOffset: CGSize = .zero
    /// Initialize previous offset.
    @State var previousOffset: CGSize = .zero
    
    /// Define button active threshold.
    let buttonActiveThreshold: CGFloat = 60
    /// Define width of button.
    let buttonWidth: CGFloat = 90
    /// Define the gaps.
    let gap: CGFloat = 10
    
    /// Store the boolean value for indicating the button is pressed or not.
    @State var pressed: Bool = false
    /// Store the pressing card BillObject.
    @State var pressingCard: BillObject? = nil
    /// Store the boolean value to delete the bill or not
    @State var deletingBill: Bool = false
    /// Define press scale factor.
    let pressScaleFactor: CGFloat = 0.95
    
    /// Card row body view.
    var body: some View {
        GeometryReader
        { geo in
            HStack (spacing: gap) {
                CardItem(card: bill)
                    .scaleEffect(allowScale(bill: bill) ? self.pressScaleFactor : 1)
                    .frame(width: editing == bill.id ? (geo.size.width + self.draggingOffset.width > 0 ? geo.size.width + self.draggingOffset.width : 0) : geo.size.width)
                
                Button(action: {
                    secondaryAction()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                        self.editing = nil
                    })
                    
                }) {
                    ZStack {
                        Image(systemName: "pencil")
                            .font(Font.title.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: editing == bill.id ? (
                            self.draggingOffset.width < 0 ?
                                (-0.5 * (self.draggingOffset.width + gap) > 0 ? -0.5 * (self.draggingOffset.width + gap) : 0) : 0) : 0, height: geo.size.height)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .shadow(color: Color.blue.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .opacity(self.draggingOffset.width < -buttonActiveThreshold ? -Double(self.draggingOffset.width + buttonActiveThreshold) / Double(2 * self.buttonWidth + 2 * gap - buttonActiveThreshold) : 0)

                Button(action: {
                    withAnimation (.spring()) {
                        self.deletingBill = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35, execute: {
                            editing = nil
                            self.deleteAction()
                        })
                    }
                    haptic_one_click()
                }) {
                    ZStack {
                        Image(systemName: "trash")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .frame(width: editing == bill.id ? (
                            self.draggingOffset.width < 0 ?
                                (-0.5 * (self.draggingOffset.width + 2 * gap) > 0 ? -0.5 * (self.draggingOffset.width + 2 * gap) : 0) : 0) : 0, height: geo.size.height)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .shadow(color: Color.red.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .opacity(self.draggingOffset.width < -buttonActiveThreshold ? -Double(self.draggingOffset.width + buttonActiveThreshold) / Double(2 * self.buttonWidth + 2 * gap - buttonActiveThreshold) : 0)
            }
            .onChange(of: editing) {_ in
                if editing == nil {
                    releaseFromEdit()
                }
            }
            .scaleEffect(y: self.deletingBill ? 0 : 1)
//            .offset(x: editing == bill.id ? self.draggingOffset.width : 0, y: 0)
            .animation(.easeOut)
            .gesture(DragGesture()
                        .onChanged { gesture in
                            if (gesture.translation.width + previousOffset.width <= 0) {
                                self.draggingOffset.width = gesture.translation.width + previousOffset.width
                            }
                            if self.draggingOffset.width <= -1.3 * (2 * self.buttonWidth + 2 * gap) {
                                self.draggingOffset.width = -1.3 * (2 * self.buttonWidth + 2 * gap)
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
                                if self.draggingOffset.width < -self.buttonActiveThreshold {
                                    self.draggingOffset.width = -(2 * self.buttonWidth + 2 * gap)
                                    self.previousOffset.width = self.draggingOffset.width
                                    editing = bill.id
                                } else {
                                    releaseFromEdit()
                                }
                            }
                            
                        })
            .onTapGesture(count: 1) {
                if self.editing != nil {
                    releaseFromEdit()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        activeBillDetail()
                    }
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
    }
    private func allowScale(bill: BillObject) -> Bool {
        return self.pressed && self.draggingOffset.width >= 0 && self.pressingCard == bill
    }
    private func releaseFromEdit() {
        self.editing = nil
        self.draggingOffset = .zero
        self.previousOffset = .zero
    }
}
