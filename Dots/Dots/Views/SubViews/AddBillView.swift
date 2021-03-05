//
//  AddBillView.swift
//  Dots
//
//  Created by Jack Zhao on 2/6/21.
//

import SwiftUI

/// Add bill view. 
struct AddBillView: View {
    /// An boolean value to show sheet view or not.
    @Binding var showSheetView: Bool
    /// A list of BillObjects.
    @Binding var billList: [BillObject]
    /// A list of the participants.
    var group: [Int]
    /// The id of bill currently working on.
    @Binding var workingOn: UUID?
    
    /// Store the attendees as a list of Int.
    @State var attendees: [Int] = []
    /// Store a string as bill title.
    @State var billTitle: String? = nil
    /// Store the date of the bill.
    @State var billDate: Date = Date()
    /// Store the bill tax as double.
    @State var billTax: Double? = nil
    /// Store the initiator.
    @State var initiator: Int = -1
    /// Store a boolean value indicate the paid status of the bill.
    @State var paid: Bool = false
    @Environment(\.colorScheme) var scheme
    
    /// Define the height of rows.
    let rowHeight: CGFloat = 60
    /// Define the size of icons.
    let iconSize: CGFloat = 26
    /// Define the radius of the table corners.
    let tableCornerRadius: CGFloat = 20
    
    /// Formate the taxrate.
    var taxRateFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    
    /// Add bill body view.
    var body: some View {
        let titleProxy = Binding<String>(
            get: {
                return (self.billTitle ?? "")
            },
            set: {
                self.billTitle = $0
            }
        )
        let taxProxy = Binding<String>(
            get: {
                if self.self.billTax == nil {
                    return ""
                }
                return taxRateFormatter.string(from: self.billTax! as NSNumber)!
            },
            set: {
                self.billTax = Double(truncating: taxRateFormatter.number(from: $0) ?? 0.0)
            }
        )

        return NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .strokeBorder(style: StrokeStyle(
                                    lineWidth: 3,
                                    dash: [15]
                                ))
                                .frame(width: 100, height: 100)
                                .overlay(
                                    Text("Creditor")
                                )
                                .foregroundColor(self.initiator < 0 ? Color.gray : classic.dotColors[self.initiator])
                                .padding()
                            if self.initiator != -1 {
                                CircleView(index: self.initiator, diameter: 90)
                            }
                        }
                        Spacer()
                    }
                    .padding(.top)


                    RoundedRectangle(cornerRadius: tableCornerRadius, style: .circular)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(height: rowHeight)
                        .overlay(
                            ScrollView (.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach (self.group, id: \.self) { g in
                                        ZStack {
                                        dotView(index: g, tapped: self.attendees.contains(g), size: 40)
                                            .onTapGesture {
                                                self.modifyGroup(member: g)
                                                haptic_one_click()
                                            }
                                            .onLongPressGesture {
                                                withAnimation {
                                                    self.initiator = g
                                                    self.modifyGroup(member: g, addOnly: true)
                                                }
                                                haptic_one_click()
                                            }
                                        }
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 5)
                                }

                            }
                            .padding(.horizontal)
                        )

                    Text("Hold an icon to select as creditor. Only one creditor is allowed per bill. Tap icon(s) to add as participant(s).")
                        .foregroundColor(Color(UIColor.systemGray2))
                        .font(.footnote)
                        .padding(.horizontal)


                    ZStack {
                        RoundedRectangle(cornerRadius: tableCornerRadius, style: .circular)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(height: rowHeight)
                            .padding(.vertical)

                        TextField("Title", text: titleProxy)
                            .font(.title3)
                            .frame(maxWidth: .infinity, maxHeight: rowHeight)
                            .padding(.horizontal)
                            .accessibility(identifier: "titleTextField")
                    }

                    RoundedRectangle(cornerRadius: tableCornerRadius, style: .circular)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(height: 3 * rowHeight)
                        .overlay(
                            VStack (spacing: 0) {
                                HStack {
                                    DatePicker(selection: self.$billDate, in: ...Date(), displayedComponents: .date) {
                                        Label {
                                            Text("Date")
                                                .font(.title3)
                                        } icon: {
                                            Image("calendarIcon")
                                                .resizable()
                                                .frame(width: iconSize, height: iconSize)
                                                .cornerRadius(5.0)
                                        }
                                    }
                                    .datePickerStyle(DefaultDatePickerStyle())
                                }
                                .frame(height: rowHeight)
                                Divider()
                                    .padding(.leading, iconSize + 5)
                                HStack {
                                    Label {
                                        Text("Tax Rate")
                                            .font(.title3)
                                    } icon: {
                                        Image("taxIcon")
                                            .resizable()
                                            .frame(width: iconSize, height: iconSize)
                                            .cornerRadius(5.0)
                                    }
                                    Spacer()
                                    TextField("0", text: taxProxy)
                                        .font(.title3)
                                        .multilineTextAlignment(.trailing)
                                        .accessibility(identifier: "taxTextField")

                                    Image(systemName: "percent")
                                }
                                .frame(height: rowHeight)
                                Divider()
                                    .padding(.leading, iconSize + 5)
                                Toggle(isOn: self.$paid) {
                                    Label {
                                        Text("Is paid")
                                            .font(.title3)
                                    } icon: {
                                        Image("paidIcon")
                                            .resizable()
                                            .frame(width: iconSize, height: iconSize)
                                            .cornerRadius(5.0)

                                    }
                                }
                                .frame(height: rowHeight)
                            }
                            .padding(.horizontal)
                        )
                    Spacer()
                }

                .padding(.horizontal)
            }
            .navigationBarColor(UIColor(primaryBackgroundColor()))
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.showSheetView.toggle()
                                        self.workingOn = nil

                                    }) {
                                        Text("Cancel")
                                    }
                                , trailing:
                                    Button(action: commitChange) {
                                        Text("Done")
                                            .fontWeight(.semibold)
                                    }
                                    .disabled(self.initiator < 0)
            )
            .navigationBarTitle(Text("Bill Details"), displayMode: .inline)
            .background(primaryBackgroundColor().ignoresSafeArea())
        }
        .ignoresSafeArea()
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
            if workingOn != nil {
                for b in self.billList {
                    if b.id == workingOn {
                        attendees = b.attendees
                        billTitle = b.title
                        billDate = b.date
                        billTax = b.taxRate
                        initiator = b.initiator
                        paid = b.paid
                        break
                    }
                }
            }
        }
    }

//     TODO: Change this later
    private func commitChange() {
        if workingOn != nil {
            for i in self.billList.indices {
                if self.billList[i].id == workingOn {
                    let tempEntry = self.billList[i].entries
                    let tempAmount = self.billList[i].billAmount
                    let newBill = BillObject(id: UUID(), title: self.billTitle ?? "Untitled Bill", date: self.billDate, attendees: self.attendees, initiator: self.initiator, paid: self.paid, tax: self.billTax ?? 0, billAmount: tempAmount, entries: tempEntry)
                    self.billList[i] = newBill
                    dismissView()
                    return
                }
            }
        } else {
            let newBill = BillObject(id: UUID(), title: self.billTitle ?? "Untitled Bill", date: self.billDate, attendees: self.attendees, initiator: self.initiator, paid: self.paid, tax: self.billTax ?? 0, billAmount: 0, entries: [])
            self.billList.append(newBill)
            dismissView()
        }
    }

    private func modifyGroup(member: Int, addOnly: Bool = false) {
        if !self.attendees.contains(member) {
            self.attendees.append(member)
            self.attendees.sort()
        } else {
            if !addOnly {
                self.attendees.remove(at: self.attendees.firstIndex(of: member)!)
                if member == initiator {
                    initiator = -1
                }
            }
        }
    }

    private func dismissView() {
        self.workingOn = nil
        self.showSheetView.toggle()
    }

    private func primaryBackgroundColor() -> Color {
        if scheme == .dark {
            return Color.black
        }
        else {
            return Color(UIColor(rgb: 0xF4F4F4))
        }
    }
}

 
struct AddBillView_Previews: PreviewProvider {
    static var previews: some View {
        AddBillView(showSheetView: .constant(true), billList: .constant([]), group: [0, 1, 2, 3, 4, 5, 6], workingOn: .constant(nil))
    }
}
