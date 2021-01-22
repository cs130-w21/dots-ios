//
//  AddBillView.swift
//  Dots
//
//  Created by Jack Zhao on 1/20/21.
//

import SwiftUI

struct AddEntryView: View {
    // MARK: Passed Variables
    @Binding var parentBill: BillObject
    let group: [Int]
    @Binding var showView: Bool
    
    // MARK: Local Variables
    @State var entryBuffer: EntryObject = .init()
    @State var tempAmount: String = ""
    @State var tempValue: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 50, height: 8, alignment: .center)
                    .foregroundColor(Color(UIColor.systemGray4))
                TextField("Untitled", text: $entryBuffer.entryTitle)
                    .font(.system(size: 36, weight: .semibold, design: .rounded))
                    
                    .padding(.leading, 16)
                    .padding(.top, 10)
                
                LinearDotSubView(selected: self.$entryBuffer.participants, all: self.group)
                    .padding(.vertical)
                
                Text("slide to select participants")
                    .font(.system(.caption, design: .rounded))
                    .foregroundColor(Color(UIColor.systemGray))
                    .padding(.top, -16)
                    
                GeometryReader { geo in
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("$")
                                .foregroundColor(.gray)
                                .bold()
                            TextField("0.0", text: $tempValue, onCommit: {
                                entryBuffer.value = Double(tempValue) ?? 0
                            })
                                .frame(width: 0.2 * geo.frame(in: .global).width)
                            .font(.system(.title, design: .rounded))
                            Image(systemName: "multiply")
                                .padding(.horizontal)
                                .font(.system(size: 20, weight: .semibold))
                                
                            TextField("1", text: $tempAmount, onCommit: {
                                entryBuffer.amount = Int(tempAmount) ?? 0
                            })
                                .frame(width: 0.2 * geo.frame(in: .global).width)
                                .font(.system(.title, design: .rounded))
                            
                            Text(Int(tempValue) ?? 0 > 1 ? "items" : "item")
                                .foregroundColor(.gray)
                                .bold()
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Total")
                                .font(.system(.body, design: .rounded))
                                .fontWeight(.semibold)
                                .padding(.trailing, 5)
                            
                            Text("$")
                                .foregroundColor(.gray)
                                .bold()
                            Text(String(format: "%.2f", (Double(tempValue) ?? 0 * Double(Int(tempAmount) ?? 1))))
                                .fontWeight(.semibold)
                                .frame(width: 0.35 * geo.frame(in: .global).width, alignment: .leading)
                                
                                .font(.system(.title, design: .rounded))
                            Text("+ Tax")
                            Image(systemName: entryBuffer.withTax ? "checkmark.circle.fill" : "checkmark.circle")
                                .frame(width: 30, height: 30)
                                .font(.system(size: 25))
                                .foregroundColor(entryBuffer.withTax ? .green : .gray)
                                .onTapGesture {
                                    withAnimation {
                                        entryBuffer.withTax.toggle()
                                    }
                                }
                            Spacer()
                        }
                        Spacer()
                    }
                }
                // MARK: Buttons
                Button(action: {
                    // TODO: Confirm button action
                    self.parentBill.entries.append(self.entryBuffer)
                    self.showView = false
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                            .frame(maxWidth: 280, maxHeight: 45)
                        Text("Confirm")
                            .font(.system(.headline))
                            .foregroundColor(.white)
                    }
                })
                Button(action: {
                    self.showView = false
                }) {
                    Text("Maybe later")
                        .font(.footnote)
                }
                .padding(.bottom, 10)
            }
            .padding()
        }
        .frame(maxWidth: 500, maxHeight: 500)
        .background(classic.secondaryBackGround)
        .clipShape(RoundedRectangle(cornerRadius: 40.0))
        .padding(.horizontal, 10)
        .shadow(radius: 20)
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView(parentBill: .constant(.init()), group: [0, 1, 2, 3, 4], showView: .constant(true))
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 Pro")
        AddEntryView(parentBill: .constant(.init()), group: [0, 1, 2, 3, 4], showView: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
