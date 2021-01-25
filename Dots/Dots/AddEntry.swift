//
//  EntryView.swift
//  Dots
//
//  Created by Guanqun Ma on 1/21/21.
//

import SwiftUI

struct AddEntry: View {
    @Binding var card: BillObject
    @Binding var entryData: EntryObject
    let attendees: [Int] = [1, 3, 5, 7, 9]
    
    @State var tempAmount: String = ""
    var body: some View {
        List {
            Section(header: Text("Entry Info")) {
                TextField("Title", text: $entryData.entryTitle)
                TextField("Amount", text: $tempAmount, onCommit: {
                    entryData.amount = Int(tempAmount) ?? 0
                })
                
            }
            Section(header: Text("Attendees")) {
                HStack {
                    Spacer()
//                    ForEach(card.attendees, id: \.self) { d in
                    ForEach(attendees, id: \.self) { d in
                        Circle()
                            .frame(maxWidth: 30, maxHeight: 30)
                            .foregroundColor(dotColors[d])
                            .opacity(1)
                        Spacer()
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
//        .navigationBarItems(leading: Button("Cancel") {
//            NavigationView {
//                ToAddEntryView()
//            }
//        })
//        .navigationBarItems(trailing: Button("Done") {
//            saveEntry()
//        })
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/,
               label: {Text("Cancel")
        })
    }
    
    func saveEntry(){
//        UserDefaults.standard.set(self.$entryData, forKey: "entryData")
        
    }
}

struct AddEntry_Previews: PreviewProvider {
    static var previews: some View {
//        EntryView()
        NavigationView {
            AddEntry(card: .constant(BillObject.sample[0]), entryData: .constant(EntryObject.sample[0]))
        }
    }
}

