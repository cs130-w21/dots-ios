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
    @State var focus: Bool = false

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button(action: { self.triggerEdit.toggle() }) {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 65, height: 30, alignment: .center)
                        .foregroundColor(Color(UIColor.systemGray5))
                        .overlay(Text(self.triggerEdit ? "Done" : "Edit")
                                    .font(.subheadline)
                                    .foregroundColor(.primary)
                                    .fontWeight(.semibold))
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom,  5)

            if (self.bill.entries.isEmpty) {
                Spacer()
                Text("No entries, add one now!")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.top, 30)
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 230), spacing: 70)], spacing: 27) {
                    ForEachWithIndex(self.bill.entries) { index, entry in
                        CustomEntryRowView(content: entry, deleteAction: {
                            self.bill.entries.remove(at: index)
                        }, editMode: self.$triggerEdit)
                    }
                    .shadow(color: Color(UIColor.systemGray6),radius: 10, x: 5, y: 10)
                }
                .padding(.horizontal, 20)
            }

            Spacer()
        }
        .padding(.top, 20)

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
            .preferredColorScheme(.light)
    }
}
