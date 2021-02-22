//
//  EntryListView.swift
//  Dots
//
//  Created by Jack Zhao on 1/25/21.
//

import SwiftUI

/// Shows a list of entries.
struct EntryListView: View {
    /// A UUID instance that represents current bill.
    @Binding var bill: BillObject
    
    /// An EntryObject instance
    @Binding var selectedEntry: UUID?
    
    /// A boolean variable to control entry detail display.
    @Binding var showEntryDetail: Bool

    /// A variable that stores the ID of entry that is being edited (swiped).
    @Binding var editingEntry: UUID?

    let taxRate: Double
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(spacing: 16) {

            if (self.bill.entries.isEmpty) {
                Button(action: {
                    withAnimation(.spring()) {
                        self.editingEntry = nil
                    }
                    activeEntryView()
                }) {
                    EntryItemView(entryInfo: nil, taxRate: 0)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 250), spacing: 50)], spacing: 20) {
                    Button(action: {
                        withAnimation(.spring()) {
                            self.editingEntry = nil
                        }
                        activeEntryView()
                    }) {
                        EntryItemView(entryInfo: nil, taxRate: 0)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    ForEachWithIndex(self.bill.entries) { index, entry in
                        Button(action: {}) {
                            EntryRowView(entry: entry, taxRate: taxRate, editing: $editingEntry, activeEntryDetail: {
                                activeEntryView(id: entry.id)
                            }, deleteAction: {
                                self.bill.entries.remove(at: index)
                            })
                        }
                        .frame(height: 100)
                    }
                }
                .padding(.horizontal, 30)
            }

            Spacer()
        }
        .padding(.top, 20)
        .onTapGesture {
            withAnimation(.spring()) {
                self.editingEntry = nil
            }
        }

    }
    private func binding(for entry: EntryObject) -> Binding<EntryObject> {
        guard let index = bill.entries.firstIndex(where: { $0.id == entry.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $bill.entries[index]
    }
    
    private func activeEntryView(id: UUID? = nil) {
        self.showEntryDetail.toggle()
        self.selectedEntry = id
    }
}

//struct EntryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        EntryListView(bill: .constant(BillObject.sample[1]), selectedEntry: .constant(EntryObject.init()), show: .constant(true))
//            .preferredColorScheme(.light)
//    }
//}
