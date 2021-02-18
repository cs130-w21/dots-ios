//
//  CardRowView.swift
//  Dots
//
//  Created by Jack Zhao on 2/18/21.
//

import SwiftUI

struct CardRowView: View {
    @Binding var bill: BillObject
    @Binding var editing: UUID?
    var namespace: Namespace.ID
    var activeBillDetail: (_: BillObject) -> ()
    
    @State var rowOffset: CGSize = .zero
    @State var draggingOffset: CGSize = .zero
    @State var previousOffset: CGSize = .zero
    
    let buttonWidth: CGFloat = 90
    let gap: CGFloat = 10
    
    @State var animationDuration: Double = 0.3
    @State var pressed: Bool = false
    @State var pressingCard: BillObject? = nil
    let pressScaleFactor: CGFloat = 0.95
    
    var body: some View {
        GeometryReader
        { geo in
            HStack (spacing: gap) {
                CardItem(card: bill)
                    .scaleEffect(allowScale(bill: bill) ? self.pressScaleFactor : 1)
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
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                        activeBillDetail(bill)
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
}
