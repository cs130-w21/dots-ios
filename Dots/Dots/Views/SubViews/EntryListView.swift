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
    var body: some View {
        VStack {
            ForEach(self.bill.entries) { entry in
                EntryItemView(entryInfo: entry)
                    .frame(maxHeight: 85)
                    .onTapGesture {
                        withAnimation {
                            show = true
                            selectedEntry = entry
                        }
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
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
