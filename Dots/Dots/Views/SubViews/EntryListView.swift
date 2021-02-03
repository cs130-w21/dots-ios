//
//  EntryListView.swift
//  Dots
//
//  Created by Jack Zhao on 1/25/21.
//

import SwiftUI

struct EntryListView: View {
    @Binding var bill: BillObject
    @Binding var selectedEntry: EntryObject
    @Binding var show: Bool
    
    @State var triggerEdit: Bool = false
    
    var body: some View {
            VStack(spacing: 16) {
                HStack {
                    Spacer()
                    Button(action: { self.triggerEdit.toggle() }) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 65, height: 30, alignment: .center)
                        .foregroundColor(Color(UIColor.systemGray4))
                        .overlay(Text(self.triggerEdit ? "Done" : "Edit")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom,  5)
                ForEachWithIndex(self.bill.entries) { index, entry in
                    CustomEntryRowView(content: entry, deleteAction: {
                            self.bill.entries.remove(at: index)
                    }, editMode: self.$triggerEdit, indices: .constant([]))
                    .padding(.horizontal)
                    .shadow(color: Color.gray.opacity(0.3),radius: 20, x: 0, y: 5)
                }
                .animation(.easeInOut)
                Spacer()
            }
            .frame(height: 500)
        
        .padding(.top, 25)
        .edgesIgnoringSafeArea(.bottom)
        
    }
    private func binding(for entry: EntryObject) -> Binding<EntryObject> {
        guard let index = bill.entries.firstIndex(where: { $0.id == entry.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $bill.entries[index]
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView(bill: .constant(BillObject.sample[1]), selectedEntry: .constant(EntryObject.init()), show: .constant(true))
    }
}
