////
////  EntryDetailView.swift
////  Dots
////
////  Created by Jack Zhao on 1/26/21.
////
//
//import SwiftUI
//
///// Displays the details of an entry to be added.
//struct DeprecatedEntryDetailView: View {
//    /// the bill this entry belongs to.
//    @Binding var parentBill: BillObject
//    /// the targeted entry to be added.
//    @Binding var target: EntryObject
//    @Binding var show: Bool
//
//    @State var tempAmount: String = ""
//    @State var tempValue: String = ""
//
//    var body: some View {
//        let amountProxy = Binding<String> (
//            get: {
//                String(Int(self.target.amount))
//            },
//            set: {
//                if let value = NumberFormatter().number(from: $0) {
//                    self.target.amount = Int(value.doubleValue)
//                }
//            }
//        )
//
//        let valueProxy = Binding<String> (
//            get: {
////                String(self.target.value, specifier: "%g")
//                let formatter = NumberFormatter()
//                formatter.maximumFractionDigits = 2
//                return formatter.string(from: NSNumber(value: self.target.value)) ?? "$0"
//            },
//            set: {
//                if let value = NumberFormatter().number(from: $0) {
//                    self.target.value = value.doubleValue
//                }
//            }
//        )
//
//        return ZStack {
//            VStack {
//                RoundedRectangle(cornerRadius: 5)
//                    .frame(width: 50, height: 8, alignment: .center)
//                    .foregroundColor(Color(UIColor.systemGray4))
//                TextField("Untitled", text: $target.entryTitle)
//                    .font(.system(size: 30, weight: .semibold, design: .rounded))
//
//                    .padding(.leading, 16)
//                    .padding(.top, 10)
//                LinearDotSubView(selected: self.$target.participants, all: self.parentBill.attendees)
//                    .padding(.vertical)
//
//                Text("slide to select participants")
//                    .font(.system(.caption, design: .rounded))
//                    .foregroundColor(Color(UIColor.systemGray))
//                    .padding(.top, -16)
//
//                GeometryReader { geo in
//                    VStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            Text("$")
//                                .foregroundColor(.gray)
//                                .bold()
//                            TextField("0.0", text: valueProxy)
//                                .keyboardType(.decimalPad)
//                                .frame(width: 0.2 * geo.frame(in: .global).width)
//                                .font(.system(.title, design: .rounded))
//                            Image(systemName: "multiply")
//                                .padding(.horizontal)
//                                .font(.system(size: 20, weight: .semibold))
//
//                            TextField("1", text: amountProxy)
//                                .keyboardType(.numberPad)
//                                .frame(width: 0.2 * geo.frame(in: .global).width)
//                                .font(.system(.title, design: .rounded))
//
//                            Text(target.amount > 1 ? "items" : "item")
//                                .foregroundColor(.gray)
//                                .bold()
//                            Spacer()
//                        }
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            Text("Total")
//                                .font(.system(.body, design: .rounded))
//                                .fontWeight(.semibold)
//                                .padding(.trailing, 5)
//
//                            Text("$")
//                                .foregroundColor(.gray)
//                                .bold()
//                            Text(String(format: "%.2f", (target.value * Double(target.amount))))
//                                .fontWeight(.semibold)
//                                .frame(width: 0.35 * geo.frame(in: .global).width, alignment: .leading)
//
//                                .font(.system(.title, design: .rounded))
//                            Text("+ Tax")
//                            Image(systemName: target.withTax ? "checkmark.circle.fill" : "checkmark.circle")
//                                .frame(width: 30, height: 30)
//                                .font(.system(size: 25))
//                                .foregroundColor(target.withTax ? .green : .gray)
//                                .onTapGesture {
//                                    withAnimation {
//                                        target.withTax.toggle()
//                                    }
//                                }
//                            Spacer()
//                        }
//                        Spacer()
//
//                    }
//                }
//                // MARK: Buttons
//                Button(action: confirmFunc, label: {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
//                            .frame(maxWidth: 280, maxHeight: 45)
//                        Text("Done")
//                            .font(.system(.headline))
//                            .foregroundColor(.white)
//                    }
//                })
//                Button(action: dismissFunc) {
//                    Text("Maybe later")
//                        .font(.footnote)
//                }
//                .padding(.bottom, 10)
//            }
//            .padding()
//        }
//        .dismissKeyboardOnTap()
//        .frame(maxWidth: 500, maxHeight: 500)
//        .background(classic.secondaryBackGround)
//        .clipShape(RoundedRectangle(cornerRadius: 40.0))
//        .padding(.horizontal, 10)
//        .shadow(radius: 20)
//    }
//
//    /// store user inputs
//    func confirmFunc() {
//        for i in self.parentBill.entries.indices {
//            if parentBill.entries[i].id == self.target.id {
//                parentBill.entries[i] = target
//                target = .init()
//                show = false
//                return
//            }
//
//        }
//        self.parentBill.entries.append(target)
//        target = .init()
//        show = false
//    }
//
//    /// dismiss user inputs
//    func dismissFunc() {
//        target = .init()
//        show = false
//    }
//}
//
//struct EntryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeprecatedEntryDetailView(parentBill: .constant(BillObject.sample[0]), target: .constant(EntryObject.init()), show: .constant(false))
//    }
//}
