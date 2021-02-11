//
//  AddBillView.swift
//  Dots
//
//  Created by Jack Zhao on 2/6/21.
//

import SwiftUI

struct AddBillView: View {
    @Binding var billList: [BillObject]
    @State var group: [Int]
    @State var attendees: [Int] = []
    @Binding var showSheetView: Bool
    
    @State var billTitle: String = ""
    @State var billDate: Date = Date()
    @State var billTax: Double = 0
    @State var initiator: Int = -1
    
    var body: some View {
        let valueProxy = Binding<String> (
            get: {
                let formatter = NumberFormatter()
                formatter.maximumFractionDigits = 2
                return formatter.string(from: NSNumber(value: self.billTax)) ?? "$0"
            },
            set: {
                if let value = NumberFormatter().number(from: $0) {
                    self.billTax = value.doubleValue
                }
            }
        )
        
        return NavigationView {
            ScrollView (showsIndicators: false) {
                VStack (spacing: 20) {
                    TextField("Untitled Bill", text: self.$billTitle)
                        .font(.system(size: 30, weight: .semibold, design: .rounded))
                        //                    .padding(.leading, 16)
                        .padding(.top, 10)
                    Divider()
                    
                    
                    DatePicker(selection: self.$billDate, in: ...Date(), displayedComponents: .date) {
                        Text("Date")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.regular)
                        Spacer()
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Tax")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.regular)
                        Spacer()
                        TextField("0", text: valueProxy)
                            .multilineTextAlignment(.trailing)
                            .font(.system(.title2, design: .rounded))
                        Text("%")
                            .font(.system(.title2, design: .rounded))
                    }
                    .frame(maxWidth: .infinity)
                    
                    BillMemberSelection(selectedGroup: self.$attendees, unselectedGroup: self.group, initiator: self.$initiator, showMiddlePrompt: true)
                    Spacer()
                    Button(action: {
                        self.showSheetView = false
                        self.addBillToCollection()
                    }) {
                        RoundedRectangle(cornerRadius: 25.0)
                            .overlay(Text("Confirm").foregroundColor(.white).bold())
                            .frame(width: 280, height: 55)
                    }
                    
                    Button(action: {
                        self.showSheetView = false
                    }) {
                        Text("Maybe later")
                            .font(.callout)
                    }
                    .padding(.top, -16)
                    .padding(.bottom, 35)
                }
                .padding(.horizontal)
                .padding(.top, 50)
                .navigationBarTitle(Text("New Bill"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.showSheetView = false
                    self.addBillToCollection()
                }) {
                    Text("Done").bold()
                })
            }
        }
        .background(BlurBackgroundView(style: .systemUltraThinMaterial))
        .ignoresSafeArea(edges: .bottom)
    }
    
    private func addBillToCollection() {
        self.billTitle = self.billTitle == "" ? "Untitled Bill" : self.billTitle
        self.billList.append(BillObject(id: UUID(), title: billTitle, date: billDate, attendees: attendees, initiator: initiator, paid: false, tax: billTax, billAmount: 0, entries: []))
    }
}

struct AddBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView(billList: .constant([]), group: [1, 2, 3], attendees: [], showSheetView: .constant(true), initiator: 0)
    }
}
