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
    @State var selected: BillObject? = nil
    
    @State var fullView: Bool = false
    @State var isDisabled: Bool = false
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ScrollView (.vertical, showsIndicators: false) {
                
                DotSelectView(show: $showDots, circleRadius: 110, inGroup: $groups, allDots: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
                        .padding(.vertical)
                        .zIndex(1.0)
                        .opacity(fullView ? 0 : 1)
                    

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 280), spacing: 20)], spacing: 25) {
                        
                        ForEach(bills) { i in
                            CardView(card: binding(for: i))
                                .frame(minHeight: 180)
                                .background(dotColors[i.initiator])
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                .shadow(color: dotColors[i.initiator].opacity(0.5),radius: 10, x: 0, y: 5)
                                .matchedGeometryEffect(id: i.id, in: namespace, isSource: selected == nil)
                                .onTapGesture {
                                    withAnimation() {
                                        fullView.toggle()
                                        selected = i
                                        isDisabled = true
                                    }
                                }
                                .disabled(isDisabled)
                        }
                        
                    }
//                    .blur(radius: showDots ? 10 : 0)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 100)
            }
            
            if selected != nil {
                ZStack {
                    BlurView()
                        .ignoresSafeArea()
                        
                    ScrollView {
                        CardView(card: binding(for: selected!))
                            
                            .frame(height: 280)
                            .background(dotColors[selected!.initiator])
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            .shadow(color: dotColors[selected!.initiator].opacity(0.5),radius: 10, x: 0, y: 5)
    //                        .padding(.top)
                            .matchedGeometryEffect(id: selected!.id, in: namespace)
                            .onTapGesture {
                                withAnimation() {
                                    fullView.toggle()
                                    selected = nil
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                        isDisabled = false
                                    })
                                    
                                }
                            }
                        VStack (alignment: .leading) {
                            ForEach(self.selected!.entries) { entry in
                                Text("\(entry.entryTitle), amount: \(entry.value)")
                                    .padding()
                            }
                        }
                        .padding(.top)
                        
                    }
                    .ignoresSafeArea(edges: .top)
                }
                .transition(.asymmetric(
                                insertion: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(0.3)),
                                removal: AnyTransition
                                    .opacity
                                    .animation(Animation.spring().delay(0))))
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
            .previewDevice("iPhone 12")
    }
}
