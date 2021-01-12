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
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
            VStack (spacing: 20) {
                //                Spacer()
                HStack {
                    ForEach(0..<5) { i in
                        CircleView(index: i, diameter: 30, hasRing: false, ringStroke: 0)
                            .scaleEffect(groups.contains(i) ? 0.6 : 1)
                            .animation(.easeIn(duration: 0.2))
                            .onTapGesture {
                                if groups.contains(i) {
                                    groups.remove(at: groups.firstIndex(of: i)!)
                                } else {
                                    groups.append(i)
                                }
                                haptic_one_click()
                            }
                        
                        
                    }
                }
                HStack {
                    ForEach(5..<10) { i in
                        CircleView(index: i, diameter: 30, hasRing: false, ringStroke: 0)
                            .scaleEffect(groups.contains(i) ? 0.6 : 1)
                            .animation(.easeIn(duration: 0.2))
                            .onTapGesture {
                                if groups.contains(i) {
                                    groups.remove(at: groups.firstIndex(of: i)!)
                                } else {
                                    groups.append(i)
                                }
                                haptic_one_click()
                            }
                        
                        
                    }
                }
                Spacer()
                Text("\(self.groups.count) people are now in group! They are: ")
                
                Text("\(self.groups.map{String($0)}.joined(separator: ","))")
                ScrollView (.vertical, showsIndicators: false) {
                    VStack (spacing: 20){
                        ForEach(bills) { i in
                            CardView(card: binding(for: i))
                                .background(Color(UIColor.systemFill))
                                .frame(width: 340, height: 200)
                                .cornerRadius(20)
                        }
                    }
                }
                //                .offset(y:100)
            }
        }
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
        HomeView(groups: .constant([1,2,3,4,5]), bills: .constant(BillObject.sample))
    }
}
