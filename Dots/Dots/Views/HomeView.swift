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
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .ignoresSafeArea()

            ScrollView (.vertical, showsIndicators: false) {
                    DotSelectView(show: $showDots, circleRadius: 110, inGroup: $groups, allDots: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
                        .padding(.vertical)
                        .zIndex(1.0)
                        .blur(radius: 0)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 280), spacing: 20)], spacing: 25) {
                        ForEach(bills) { i in
                            CardView(card: binding(for: i))
                                .frame(minHeight: 180, maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                .shadow(radius: 10, x: 5, y: 5)
                        }
                    }
                    .blur(radius: showDots ? 10 : 0)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 100)
            }
        }
        .onTapGesture {
            if showDots {
                withAnimation {
                    showDots = false
                }
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
        HomeView(groups: .constant([1,2,3,4,5]), bills: .constant(BillObject.sample), showDots: false)
            .previewDevice("iPhone 11")
    }
}
