//
//  HomeView.swift
//  Dots
//
//  Created by Jack Zhao on 1/11/21.
//

import SwiftUI

struct HomeView: View {
    @Binding var groups: [Int]
    @Binding var bills: [BillObject]
    @State var showDots: Bool = false
    
    /*added*/
    @State var showingAlert: Bool = false
  //  @State var cur_bill: String = ""
    @State private var isPresented = false
    @State var newBill : BillObject
    /*added*/
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()

            ScrollView (.vertical, showsIndicators: false) {
                    DotSelectView(show: $showDots, circleRadius: 110, inGroup: $groups, allDots: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
                        .padding(.vertical)
                        .zIndex(1.0)
                        .blur(radius: 0)
                
                /*added*/
                Button(action: { isPresented=true}) {
                    Image(systemName: "plus.circle.fill")
                }
    
                /*added*/
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 280), spacing: 20)], spacing: 25) {
                        ForEach(bills) { i in

                        //added a new button for each card view
                            CardView(card: binding(for: i))
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                .shadow(radius: 10, x: 5, y: 5)
                                /*
                                .onTapGesture{
                                    self.cur_bill = i.title
                                    self.showingAlert = true
                                    
                                }
                                */
                        }
                    }

                    .blur(radius: showDots ? 10 : 0)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 100)
            }
            /*
            .navigationBarItems(trailing: Button(action: {
                isPresented = true
                }) {
                    Image(systemName: "plus.circle.fill")})
            */
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    AddBillView(bill: $newBill)
                        .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        /* NEED TO ADD MORE STUFFS BELOW!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
                        /* ex: initialtor, participants*/
                        let newBillObj = BillObject(title: newBill.title, date: newBill.date, attendees: [0, 1, 3, 5, 9], initiator: 9, paid: false, billAmount: 67.9, entries: EntryObject.sample)
                        bills.append(newBillObj)
                        isPresented = false
                    })
                }
            }
        }

        
        /*
        
        
        .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("Error"), message: Text("Bill is: \(cur_bill)"), dismissButton: .default(Text("OK")))
                })
        /*added*/
        .onTapGesture {
            if showDots {
                withAnimation {
                    showDots = false
                }
            }
        }
 */

        
    }
    
    private func binding(for bill: BillObject) -> Binding<BillObject> {
        guard let billIndex = bills.firstIndex(where: { $0.id == bill.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $bills[billIndex]
    }
}

 
 
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
       // HomeView(groups: .constant([1,2,3,4,5]), bills: .constant(BillObject.sample), showDots: false, cur_bill: "", newBill: BillObject.sample[0])
        HomeView(groups: .constant([1,2,3,4,5]), bills: .constant(BillObject.sample), showDots: false, newBill: BillObject())
          //  .previewDevice("iPhone 11")
    }
}

