//
//  BillDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI



struct BillDetailView: View {
    @Binding var chosenBill: BillObject
    var namespace: Namespace.ID
    let dismissBillDetail: () -> ()
    let animationDuration: Double
    
    @State var scrollOffset: CGFloat = .zero
    @State var selectedEntry: EntryObject = .init()
    @State var showEntry: Bool = false
    @State var onRemoving: Bool = false
    @State var showEntries: Bool = false
    
    
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        typealias Value = [CGFloat]
        
        static var defaultValue: [CGFloat] = [0]
        
        static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
            value.append(contentsOf: nextValue())
        }
    }
    
    var body: some View {
        ZStack {
            GeometryReader { outGeo in
                ScrollView (.vertical, showsIndicators: false) {
                    VStack {
                        ZStack {
                            GeometryReader { innerProxy in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self, value: [self.getScrollViewOffset(outProxy: outGeo, innerProxy: innerProxy)])
                            }
                            CardItem(card: self.chosenBill)
                                .matchedGeometryEffect(id: self.chosenBill.id, in: namespace)
                                .frame(height: 230)
                                .onTapGesture {
                                    withAnimation {
                                        dismissBillDetail()
                                    }
                                    haptic_one_click()
                                }
                        }
                        
                        EntryListView(bill: self.$chosenBill, selectedEntry: self.$selectedEntry, show: self.$showEntry)
                            .opacity(self.showEntries ? 1 : 0)
                            .animation(.easeOut(duration: animationDuration))
                    }
                    .scaleEffect(self.scrollOffset > 0 ? 1 - (self.scrollOffset/120.0)*0.1 : 1)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + 0.1) {
                        self.showEntries.toggle()
                    }
                }
                .onDisappear {
                    self.showEntries.toggle()
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    self.scrollOffset = value[0]
                }
                .background(BlurBackgroundView(style: .systemUltraThinMaterial))
            }
            
            VStack {
                Spacer()
                EntryDetailView(parentBill: self.$chosenBill, target: self.$selectedEntry, show: self.$showEntry)
                    .offset(y: showEntry ? 0 : 800)
                if !showEntry {
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showEntry = true
                            }
                        }) {
                            Circle()
                                .frame(width: 80, height: 80)
                        }
                        .padding(.bottom)
                        .padding(.trailing)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.vertical)
        .onChange(of: self.scrollOffset, perform: { value in
            if value > 120 {
                if !onRemoving {
                    onRemoving = true
                    haptic_one_click()
                }
                withAnimation (.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.2)) {
                    dismissBillDetail()
                }
            }
        })
    }
    
    private func getScrollViewOffset(outProxy: GeometryProxy, innerProxy: GeometryProxy) -> CGFloat {
        return -outProxy.frame(in: .global).minY + innerProxy.frame(in: .global).minY
    }
}

struct BillDetailView_Preview: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        BillDetailView(chosenBill: .constant(BillObject.sample[1]), namespace: namespace, dismissBillDetail: {}, animationDuration: 0.3, selectedEntry: .init())
            .previewDevice("iPhone 12 Pro Max")
            .preferredColorScheme(.light)
    }
}
