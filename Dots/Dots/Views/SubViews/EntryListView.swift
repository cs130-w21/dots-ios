//
//  EntryListView.swift
//  Dots
//
//  Created by Jack Zhao on 1/25/21.
//

import SwiftUI

struct EntryListView: View {
    @Binding var bill: BillObject
    var body: some View {
        VStack {
            ForEach(self.bill.entries) { entry in
                EntryView(entryInfo: entry)
                    .frame(maxHeight: 85)
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .padding(.top, 25)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView(bill: .constant(BillObject.sample[1]))
    }
}
