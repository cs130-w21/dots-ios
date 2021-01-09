//
//  BillCardView.swift
//  Dots
//
//  Created by Jack Zhao on 1/8/21.
//

import SwiftUI

struct BillCardView: View {
    @State var singleBill: BillObject
    @State var dots: [DotObject] = dotsInit()
    var body: some View {
        VStack {
            ZStack {
                
                VStack {
                    Spacer()
                    // MARK: Dots View
                    HStack {
                        ForEachWithIndex(dots) { i, d in
                            if (singleBill.initiatorIndex == i) {
                                Image(systemName: "circle.fill")
                                    .scaleEffect(1.5)
                                    .foregroundColor(d.color)
                            }
                            else if (singleBill.participantsIndex.contains(i)) {
                                Image(systemName: "circle.fill")
                                    .scaleEffect(1)
                                    .foregroundColor(d.color)
                                
                            }
                            else {}
                        }
                    }
                    .padding(.bottom)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                // MARK: Bill Title
                                Text(singleBill.title)
                                    .font(.system(.title, design: .rounded))
                                    .fontWeight(.semibold)
                                
                                // MARK: PAID mark
                                if (singleBill.paid) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color(UIColor.systemBlue))
                                        .imageScale(.large)
                                }
                                else {
                                    Image(systemName: "checkmark.circle.fill")
                                        .opacity(0)
                                        .imageScale(.large)
                                }
                            }
                            
                            // MARK: Date string
                            Text(singleBill.dateCreated)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color(UIColor.systemGray))
                        }
                        Spacer()
                        
                        // MARK: Bill Total
                        Text(singleBill.getBillTotal())
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.semibold)
                    }
                    .padding()
                    Spacer()
                }
                
            }
            .shadow(radius: 24)
        }
        .frame(minWidth: 320, idealWidth: 350, maxWidth: 350, maxHeight: 200, alignment: .leading)
        .background(Color.init(UIColor.systemGray5))
        .cornerRadius(40)
        .shadow(radius: 20)
    }
}

struct BillCardView_Previews: PreviewProvider {
    static var previews: some View {
        BillCardView(singleBill: BillObject(title: "Bill Title", dateCreated: "Jan 6, 2021", paid: true, initiator: 1, participants: [1, 3, 5, 6, 7]))
            .previewLayout(.sizeThatFits)
     
        BillCardView(singleBill: BillObject(title: "Bill Title", dateCreated: "Jan 6, 2021", paid: true, initiator: 1, participants: [1, 3, 5, 6, 7]))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    
        BillCardView(singleBill: BillObject(title: "Bill Title", dateCreated: "Jan 6, 2021", paid: true, initiator: 1, participants: [3, 5, 6, 7]))
            .previewDevice("iPhone 12 mini")
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
        BillCardView(singleBill: BillObject(title: "Bill Title", dateCreated: "Jan 6, 2021", paid: true, initiator: 1, participants: [3, 5, 6, 7]))
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (9.7-inch)"))
    }
}
