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
        LazyVStack(spacing: 16) {
                ScrollView {
                    VStack {
                        ForEachWithIndex(self.bill.entries) { index, entry in
                            CustomEntryRowView(content: entry, deleteAction: {
                                self.bill.entries.remove(at: index)
                            }, editMode: self.$triggerEdit, indices: .constant([]))
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 25)
                .edgesIgnoringSafeArea(.bottom)
            }
        
    }
    private func binding(for entry: EntryObject) -> Binding<EntryObject> {
        guard let index = bill.entries.firstIndex(where: { $0.id == entry.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $bill.entries[index]
    }
}

//struct EntryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryListView(bill: .constant(BillObject.sample[1]), selectedEntry: .constant(EntryObject.init()), show: .constant(true))
//    }
//}
