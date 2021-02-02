//
//  CustomListView.swift
//  Dots
//
//  Created by Jack Zhao on 2/1/21.
//

import SwiftUI

struct CustomListRow: View {
    let content: EntryObject
    let deleteAction: () -> ()
    var editMode: Bool
    
    let width: CGFloat = 80
    let rowHeight: CGFloat = 100
    @Binding var indices: [Int]
    @State var draggingOffset = CGSize.zero
    @State var previousOffset = CGSize.zero
    @State var opacity: Double = 0
    @State var beingDeleted = false
    
    var body: some View {
        GeometryReader { geo in
            HStack (spacing: 9){
                ZStack {
                EntryItemView(entryInfo: self.content)
                    .animation(.easeOut)
                    .frame(width: geo.size.width, height: self.rowHeight, alignment: .leading)
                    VStack {
                        Text("EditMode: \(self.editMode ? "yes" : "no")")
                    
                    }
                }
                ZStack {
                    Image(systemName: "trash")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                    
                }
                
                .frame(width: -self.draggingOffset.width, height: self.rowHeight)
                .background(BlurBackgroundView())
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                .opacity(self.draggingOffset.width < -35 ? -Double(self.draggingOffset.width)/80.0
                            : 0)
                .onTapGesture {
                    withAnimation {
                        self.beingDeleted = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.25, execute: deleteAction)
                    }
                }
                
            }
            .frame(maxHeight: self.rowHeight)
            .offset(self.draggingOffset)
            .animation(.spring())
            .gesture(DragGesture()
                        .onChanged { gesture in
                            // Add translation to current draggin offset
                            self.draggingOffset.width = gesture.translation.width + previousOffset.width
                            
                        }
                        .onEnded { _ in
                            if self.draggingOffset.width < -35 {
                                self.draggingOffset.width = -(self.width + 5)
                                self.previousOffset.width = self.draggingOffset.width
                            } else {
                                self.draggingOffset = .zero
                                self.previousOffset = .zero
                            }
                        })
        }
        
        .scaleEffect(x: 1, y: self.beingDeleted ? 0 : 1)
        .animation(.spring(response: 0.3, dampingFraction: 0.9, blendDuration: 0.1))
        .frame(height: self.rowHeight)
        .onAppear(perform: {
            withAnimation {
                if editMode {
                    self.draggingOffset.width = -(self.width + 5)
                    self.previousOffset.width = self.draggingOffset.width
                } else {
                    self.draggingOffset = .zero
                    self.previousOffset = .zero
                }
            }
        })
    }
}
struct CustomListView: View {
    @State var tmp = BillObject.sample[0].entries
    @State var edit: [Int:Bool] = [0:false]
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                Text("My List")
                    .font(.system(size: 40))
                    .bold()
                    .frame(width: geo.size.width * 0.95, alignment: .leading)
                    .padding(.top, 50)
                Button("Toggle") {
                    if !(self.edit[0] ?? false) {
                        for i in 0..<self.tmp.count {
                            self.edit[i] = true
                        }
                    } else {
                        for i in 0..<self.tmp.count {
                            self.edit[i] = false
                        }
                    }
                    
                }
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEachWithIndex(self.tmp) { index, entry in
                            CustomListRow(content: entry, deleteAction: {
                                self.tmp.remove(at: index)
                            }, editMode: self.edit[index] ?? false, indices: .constant([]))
                            .padding(.horizontal)
                        }
                    }
                    HStack {
                        ForEach(0..<self.tmp.count) { i in
                            Text("\(i), \(self.edit[i] ?? false ? "edit" : "no")")
                                .padding(.horizontal)
                        }
                    }
                }
                
            }
        }.background(Color.gray)
        
    }
}

struct CustomListView_Previews: PreviewProvider {
    static var previews: some View {
        CustomListView()
            .previewDevice(.init(stringLiteral: "iPhone 12"))
    }
}
