//
//  BillDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI



/// Displays the details of a bill
struct BillDetailView: View {
    /// the current bill chosen to display
    @Binding var chosenBill: BillObject
    var namespace: Namespace.ID
    let dismissBillDetail: () -> ()
    let animationDuration: Double

    @State var scrollOffset: CGFloat = .zero
    @State var selectedEntry: EntryObject = .init()
    @State var showEntry: Bool = false
    @State var onRemoving: Bool = false
    @State var showEntries: Bool = false
    @State var showViewBackground: Bool = false
    @State var showBackground: Bool = false
    let pullToDismissDistance: CGFloat = 120.0

    struct ScrollOffsetPreferenceKey: PreferenceKey {
        typealias Value = [CGFloat]
        static var defaultValue: [CGFloat] = [0]
        static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
            value.append(contentsOf: nextValue())
        }
    }

    var body: some View {
        ZStack {
            BlurBackgroundView(style: .systemUltraThinMaterial)
                .opacity(self.showViewBackground ? 1 : 0)
                .onTapGesture {
                    tapToDismiss()
                }
            ZStack {
                BlurBackgroundView(style: .systemThickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .scaleEffect(x: self.scrollOffset > 0 ? 1 - (self.scrollOffset/pullToDismissDistance)*0.1 : 1)
                    .shadow(radius: 10)
                    .opacity(self.showViewBackground ? Double((self.scrollOffset > 0 ? 1 - self.scrollOffset/self.pullToDismissDistance : 1)) : 0)
                    .animation(.linear(duration: 0.15))
                    .offset(x: 0, y: self.scrollOffset > 0 ? self.scrollOffset : 0)

                GeometryReader { outGeo in
                    ScrollView (.vertical, showsIndicators: false) {
                        VStack {
                            ZStack {
                                GeometryReader { innerProxy in
                                    Color.clear
                                        .preference(key: ScrollOffsetPreferenceKey.self, value: [self.getScrollViewOffset(outProxy: outGeo, innerProxy: innerProxy)])
                                }
                                GeometryReader { geo in
                                    HStack (spacing: 10) {
                                        CardItem(card: self.chosenBill)
                                            .frame(width: geo.size.width)
                                    }
                                }
                                .animation(.easeOut)
                                .matchedGeometryEffect(id: self.chosenBill.id, in: namespace)
                                .frame(height: 230)
                                .onTapGesture {
                                    tapToDismiss()
                                }
                            }

                            EntryListView(bill: self.$chosenBill, selectedEntry: self.$selectedEntry, show: self.$showEntry)
                                .opacity(self.showEntries ? Double((self.scrollOffset > 0 ? 1 - self.scrollOffset/self.pullToDismissDistance : 1)) : 0)
                                .animation(.easeOut(duration: animationDuration))
                        }
                        .scaleEffect(self.scrollOffset > 0 ? 1 - (self.scrollOffset/pullToDismissDistance)*0.1 : 1)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                            withAnimation {
                                self.showViewBackground.toggle()
                                self.showBackground.toggle()
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + 0.1) {
                            withAnimation {
                                self.showEntries.toggle()
                            }
                        }
                    }
                    .onDisappear {
                        withAnimation {
                            self.showBackground.toggle()
                            self.showViewBackground.toggle()
                            self.showEntries.toggle()
                        }
                    }
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        self.scrollOffset = value[0]
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: 650)
            .onChange(of: self.scrollOffset, perform: { value in
                if value > pullToDismissDistance {
                    if !onRemoving {
                        onRemoving = true
                        haptic_one_click()
                        print("There are \(chosenBill.entries.count) entries")
                    }
                    dragToDismiss()
                }
            })
        }
        .ignoresSafeArea()
    }

    private func getScrollViewOffset(outProxy: GeometryProxy, innerProxy: GeometryProxy) -> CGFloat {
        return -outProxy.frame(in: .global).minY + innerProxy.frame(in: .global).minY
    }
    
    private func tapToDismiss() {
        withAnimation (.spring(response: 0.4, dampingFraction: 0.75, blendDuration: 0.2)) {
            dismissBillDetail()
        }
        haptic_one_click()
    }
    
    private func dragToDismiss() {
        withAnimation (.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0.2)) {
            dismissBillDetail()
        }
    }
}

struct BillDetailView_Preview: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        BillDetailView(chosenBill: .constant(BillObject.sample[1]), namespace: namespace, dismissBillDetail: {}, animationDuration: 0.3, selectedEntry: .init())
            .previewDevice("iPhone 12")
            .preferredColorScheme(.light)
    }
}
