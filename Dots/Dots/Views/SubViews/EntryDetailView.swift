//
//  EntryDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 2/21/21.
//

import SwiftUI

struct EntryDetailView: View {
    @Binding var parentBill: BillObject
    @Binding var entryID: UUID?
    @Binding var displaySheet: Bool
    
    
    var body: some View {
        NavigationView {
            
        }
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(parentBill: .constant(BillObject.sample[0]), entryID: .constant(nil), displaySheet: .constant(true))
    }
}
