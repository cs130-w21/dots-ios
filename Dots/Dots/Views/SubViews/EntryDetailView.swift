//
//  EntryDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 2/21/21.
//

import SwiftUI

/// Entry detail view.
struct EntryDetailView: View {
    /// An instance of BillObject for parent bill.
    @Binding var parentBill: BillObject
    /// Entry ID.
    @Binding var entryID: UUID?
    /// Boolean value indicates whether show the sheet view or not
    @Binding var showSheetView: Bool
    
    /// Store the entry tile as string.
    @State var entryTitle: String = ""
    /// Store the attendees as a list of Int.
    @State var attendees: [Int] = []
    /// Store the entry value with double type.
    @State var entryValue: Double? = nil
    /// Store the entry amount as Int.
    @State var entryAmount: Int? = nil
    /// Store a boolean value to check whether the entry has tax.
    @State var entryHasTax: Bool = false
    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
    
    /// Set corner radius for tables.
    let tableCornerRadius: CGFloat = 20
    /// Set height for rows.
    let rowHeight: CGFloat = 70
    /// Set icon size.
    let iconSize: CGFloat = 26
    
    /// Initialize the value format.
    var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    /// Initialize the amount format.
    var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    /// Entry detail body view.
    var body: some View {
        let priceProxy = Binding<String>(
            get: {
                if self.entryValue == nil {
                    return ""
                }
                return valueFormatter.string(from: self.entryValue! as NSNumber)!
            },
            set: {
                
                self.entryValue = Double(truncating: valueFormatter.number(from: $0) ?? 0.0)
            }
        )
        
        let amountProxy = Binding<String>(
            get: {
                if self.entryAmount == nil {
                    return ""
                }
                return amountFormatter.string(from: self.entryAmount! as NSNumber)!
            },
            set: {
                
                self.entryAmount = Int(exactly: amountFormatter.number(from: $0) ?? 1)
            }
        )
        
        return NavigationView {
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("$ \(self.getLocalTotal(), specifier: "%.2f")")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.semibold)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .accessibility(identifier: "entryTotal")
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 30)
                VStack {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: tableCornerRadius, style: .circular)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(height: rowHeight)
                            .padding(.vertical)
                    
                        TextField("Entry Title", text: self.$entryTitle)
                            .font(.title3)
                            .frame(maxWidth: .infinity, maxHeight: rowHeight)
                            .padding(.horizontal)
                            .accessibility(identifier: "titleTextField")
                    }
                    
                    RoundedRectangle(cornerRadius: tableCornerRadius, style: .circular)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .frame(height: rowHeight)
                        .overlay(
                            ScrollView (.horizontal, showsIndicators: false){
                                HStack {
                                    ForEach (self.parentBill.attendees, id: \.self) { g in
                                        dotView(index: g, tapped: self.attendees.contains(g), size: 40)
                                            .onTapGesture {
                                                withAnimation {
                                                    self.modifyGroup(member: g)
                                                }
                                                haptic_one_click()
                                            }
                                            .accessibility(identifier: "dot-\(g)")
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 5)
                                }
                            }
                            .padding(.horizontal)
                        )
                    HStack (spacing: 0) {
                        if self.attendees.count == 0 {
                            Text("* required")
                                .foregroundColor(.red)
                                .font(.footnote)
                        }
                        Text("Tap on dots to select participants")
                            .foregroundColor(Color(UIColor.systemGray2))
                            .font(.footnote)
                            .padding(.horizontal)
                    }

                    
                    ZStack {
                        let rowNum: CGFloat = self.entryHasTax ? 4 : 3
                        RoundedRectangle(cornerRadius: tableCornerRadius, style: .circular)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .frame(height: rowNum * rowHeight)
                            .padding(.vertical)
                            .animation(.easeOut(duration: 0.2))
                    
                        VStack (spacing: 0) {
                            HStack {
                                Label {
                                    Text("Price")
                                        .font(.title3)
                                } icon: {
                                    Image(systemName: "dollarsign.square.fill")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: iconSize, height: iconSize)
                                        .cornerRadius(5.0)
                                }
                                Spacer()
                                TextField("required: 0.00", text: priceProxy)
                                    .font(.title3)
                                    .multilineTextAlignment(.trailing)
                                    .accessibility(identifier: "priceTextField")
                            }
                            .frame(height: rowHeight)
                            
                            Divider()
                                .padding(.leading, iconSize + 5)
                            
                            HStack {
                                Label {
                                    Text("Quantity")
                                        .font(.title3)
                                } icon: {
                                    Image(systemName: "number.square.fill")
                                        .resizable()
                                        .foregroundColor(.blue)
                                        .frame(width: iconSize, height: iconSize)
                                        .cornerRadius(5.0)
                                }
                                Spacer()
                                TextField("1", text: amountProxy)
                                    .font(.title3)
                                    .multilineTextAlignment(.trailing)
                                    .accessibility(identifier: "quantityTextField")
                            }
                            .frame(height: rowHeight)
                            
                            Divider()
                                .padding(.leading, iconSize + 5)
                            
                            Toggle(isOn: self.$entryHasTax) {
                                Label {
                                    Text("Has Tax")
                                        .font(.title3)
                                } icon: {
                                    Image("taxIcon")
                                        .resizable()
                                        .frame(width: iconSize, height: iconSize)
                                        .cornerRadius(5.0)
                                }
                            }
                            .frame(height: rowHeight)
                            .accessibility(identifier: "taxSwitch")
                            
                            if self.entryHasTax {
                                Divider()
                                    .padding(.leading, iconSize + 5)
                                HStack {
                                    Spacer()
                                    Text("+ Tax: \(Double(self.entryAmount ?? 1) * (self.entryValue ?? 0.0) * self.parentBill.taxRate/100.0, specifier: "%.2f") (\(self.parentBill.taxRate, specifier: "%.2f") %)")
                                        .font(.callout)
                                        .foregroundColor(.gray)
                                        .frame(height: rowHeight)
                                        .animation(.easeOut(duration: 0.2))
                                        .accessibility(identifier: "estimateTax")
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarColor(UIColor(primaryBackgroundColor()))
            .navigationBarItems(leading:
                                    Button(action: {
                                        dismissView()
                                    }) {
                                        Text("Cancel")
                                    }
                                , trailing:
                                    Button(action: {
                                        commitChange()
                                        dismissView()
                                    }/*commitChange*/) {
                                        Text("Done")
                                            .fontWeight(.semibold)
                                    }
                                    .disabled(self.entryValue == nil || self.attendees.count == 0)
            )
            .navigationBarTitle(Text("Entry Details"), displayMode: .inline)
            .background(primaryBackgroundColor().ignoresSafeArea())
        }
        .ignoresSafeArea()
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
            if entryID != nil {
                for e in self.parentBill.entries {
                    if e.id == entryID {
                        entryTitle = e.entryTitle
                        attendees = e.getParticipants()
                        entryValue = e.value
                        entryAmount = e.amount
                        entryHasTax = e.withTax
                        break
                    }
                }
            }
        }
    }
    
    private func modifyGroup(member: Int) {
        if !self.attendees.contains(member) {
            self.attendees.append(member)
            self.attendees.sort()
        } else {
            self.attendees.remove(at: self.attendees.firstIndex(of: member)!)
        
        }
    }
    
    private func primaryBackgroundColor() -> Color {
        if scheme == .dark {
            return Color.black
        }
        else {
            return Color(UIColor(rgb: 0xF4F4F4))
        }
    }
    
    private func getLocalTotal() -> Double {
        var ret: Double = 0
        if self.entryHasTax {
            ret = Double(self.entryAmount ?? 1) * (self.entryValue ?? 0.0) + getLocalTax()
        } else {
            ret = Double(self.entryAmount ?? 1) * (self.entryValue ?? 0.0)
        }
        return ret
    }
    
    private func getLocalTax() -> Double {
        return Double(self.entryAmount ?? 1) * (self.entryValue ?? 0.0) * self.parentBill.taxRate/100.0
    }
    
    private func commitChange() {
        if entryID != nil {
            for i in self.parentBill.entries.indices {
                if self.parentBill.entries[i].id == entryID {
                    self.parentBill.entries[i].entryTitle = self.entryTitle
                    self.parentBill.entries[i].amount = self.entryAmount ?? 1
                    self.parentBill.entries[i].value = self.entryValue ?? 0
                    self.parentBill.entries[i].withTax = self.entryHasTax
                    self.parentBill.entries[i].participants = self.attendees
                    return
                }
            }
        } else {
            let newEntry = EntryObject(id: UUID(), entryTitle: self.entryTitle, participants: self.attendees, value: self.entryValue!, amount: self.entryAmount ?? 1, withTax: self.entryHasTax)
            self.parentBill.entries.insert(newEntry, at: 0)
        }
    }
    
    private func dismissView() {
        self.entryID = nil
        self.showSheetView.toggle()
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(parentBill: .constant(BillObject.sample[0]), entryID: .constant(nil), showSheetView: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
