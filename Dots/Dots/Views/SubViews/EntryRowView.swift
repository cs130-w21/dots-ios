//
//  EntryRowView.swift
//  Dots
//
//  Created by Jack Zhao on 2/21/21.
//

import SwiftUI

struct EntryRowView: View {
    @State var entry: EntryObject
    var taxRate: Double
    @Binding var editing: UUID?
    var activeEntryDetail: () -> ()
    var deleteAction: () -> ()
    
    @State var draggingOffset: CGSize = .zero
    @State var previousOffset: CGSize = .zero
    
    let buttonActiveThreshold: CGFloat = 30
    let buttonWidth: CGFloat = 80
    let gap: CGFloat = 10
    let cornerRadius: CGFloat = 20
    
    var body: some View {
        GeometryReader { geo in

            HStack {
                EntryItemView(entryInfo: entry, taxRate: taxRate)
                    .frame(width: editing == self.entry.id ? (geo.size.width + self.draggingOffset.width > 0 ? geo.size.width + self.draggingOffset.width : 0) : geo.size.width, height: geo.size.height)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                Button(action: {
                    deleteAction()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                        self.editing = nil
                    })
                    
                }) {
                    ZStack {
                        Image(systemName: "trash")
                            .font(Font.title.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: editing == self.entry.id ? (
                            self.draggingOffset.width < 0 ?
                                (-(self.draggingOffset.width + gap) > 0 ? -(self.draggingOffset.width + gap) : 0) : 0) : 0, height: geo.size.height)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .shadow(color: Color.red.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .opacity(self.draggingOffset.width < -buttonActiveThreshold ? -Double(self.draggingOffset.width + buttonActiveThreshold) / Double(self.buttonWidth + gap - buttonActiveThreshold) : 0)

            
            
            }
            .animation(.easeOut)
            .gesture(DragGesture()
                        .onChanged { gesture in
                            if (gesture.translation.width + previousOffset.width <= 0) {
                                self.draggingOffset.width = gesture.translation.width + previousOffset.width
                            }
                            if self.draggingOffset.width <= -1.5 * buttonWidth {
                                self.draggingOffset.width = -1.5*(buttonWidth + gap)
                            }
                            if editing != self.entry.id {
                                self.draggingOffset = .zero
                                self.previousOffset = .zero
                                editing = self.entry.id
                            }
                        }
                        .onEnded { gesture in
                            if gesture.translation.width > 0 {
                                editing = nil
                            } else {
                                if self.draggingOffset.width < -self.buttonActiveThreshold {
                                    self.draggingOffset.width = -(self.buttonWidth + gap)
                                    self.previousOffset.width = self.draggingOffset.width
                                    editing = self.entry.id
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
                        activeEntryDetail()
                    }
                }
            
            }
        }
    }
    
    private func releaseFromEdit() {
        self.editing = nil
        self.draggingOffset = .zero
        self.previousOffset = .zero
    }
}

//struct EntryRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryRowView(entry: nil)
//    }
//}
