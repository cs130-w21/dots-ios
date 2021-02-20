////
////  AddEntry.swift
////  Dots
////
////  Created by Guanqun Ma on 1/21/21.
////
//
//import SwiftUI
//
//struct AddEntry: View {
//    @Binding var card: BillObject
//    @Binding var entryData: EntryObject
//    let attendees: [Int] = [1, 3, 5, 7, 9]
//    
//    @State var tempAmount: String = "" // for later integer conversion of amount typed
//    @State var tempAttendees: [Int] = [] // for later storage of participants of current entry
//    var body: some View {
//        VStack {
//            List {
//                Section(header: Text("Entry Info")) {
//                    TextField("Title", text: $entryData.entryTitle)
//                    TextField("Amount", text: $tempAmount, onCommit: {
//                        entryData.amount = Int(tempAmount) ?? 0
//                    })
//                    
//                }
//                Section(header: Text("Attendees")) {
//                    HStack {
//                        Spacer()
//    //                    ForEach(card.attendees, id: \.self) { d in
//                        ForEach(attendees, id: \.self) { d in
//                            Circle()
//                                .frame(maxWidth: 30, maxHeight: 30)
//                                .foregroundColor(dotColors[d])
//                                .opacity(1)
//                                .onTapGesture(perform: {
//                                    tempAttendees.append(d)
//                                })
//                            Spacer()
//                        }
//                    }
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            .padding()
//            Button(action: {saveEntry()},
//                   label: {Text("Done")
//            })
//            padding()
////            Button(action: {}, // Action to be added
////                   label: {Text("Cancel")
////            })
//        }
//    }
//    
//    func saveEntry() {
//        entryData.participants = tempAttendees
//        card.entries.append(entryData)
//    }
//}
//
//struct AddEntry_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            AddEntry(card: .constant(BillObject.sample[0]), entryData: .constant(EntryObject.sample[0]))
//        }
//    }
//}
//
