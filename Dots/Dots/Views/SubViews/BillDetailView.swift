//
//  BillDetailView.swift
//  Dots
//
//  Created by Jack Zhao on 1/24/21.
//

import SwiftUI



/// Displays the details of a bill
struct BillDetailView: View {
    /// An Billobject instance represents the chosen bill.
    @Binding var chosenBill: BillObject
    /// Namespace.
    var namespace: Namespace.ID
    /// Dissmiss the bill detail.
    let dismissBillDetail: () -> ()
    /// A double representing the animation duration time.
    let animationDuration: Double
    /// Set the background color.
    let background: Color
    /// Set the top offset.
    let topOffset: CGFloat
    
    /// Stores UUID of current entry that is being edited.
    @State var editingEntry: UUID? = nil
    /// Set the scroll offset.
    @State var scrollOffset: CGFloat = .zero
    /// Stores UUID of selected entry.
    @State var selectedEntry: UUID? = nil
    /// A boolean value indicating whether to show the entry detail or not.
    @State var showEntryDetail: Bool = false
    
    /// Store the boolean value indicating whether is on removing or not.
    @State var onRemoving: Bool = false
    /// Store the boolean value that determines to show entries or not.
    @State var showEntries: Bool = false
    /// Store the boolean value whether show the background of view or not.
    @State var showViewBackground: Bool = false
    /// Store the boolean value whether show the background or not.
    @State var showBackground: Bool = false
    /// Set the distance to pull to dismiss.
    let pullToDismissDistance: CGFloat = 120.0
    
    /// Define Preference key of scroll offset.
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        typealias Value = [CGFloat]
        static var defaultValue: [CGFloat] = [0]
        static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
            value.append(contentsOf: nextValue())
        }
    }
    
    /// Body view of bill detail.
    var body: some View {
        ZStack {

            BlurBackgroundView(style: .systemUltraThinMaterial)
                .opacity(self.showViewBackground ? 1 : 0)
                .onTapGesture {
                    tapToDismiss()
                }
                .cornerRadius(topOffset > 0 ? 0 : 25.0)

            ZStack {
                background
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .scaleEffect(x: self.scrollOffset > 0 ? 1 - (self.scrollOffset/pullToDismissDistance)*0.1 : 1)
                    .shadow(radius: 10)
                    .opacity(self.showViewBackground ? Double((self.scrollOffset > 0 ? 1 - self.scrollOffset/self.pullToDismissDistance : 1)) : 0)
                    .animation(.linear(duration: self.scrollOffset > 0 ? 0.01 : 0.15))
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
                                        CardItem(card: self.chosenBill, cornerRadius: self.showEntryDetail ? 12.0 : 25.0)
                                            .frame(width: geo.size.width)
                                    }
                                }
                                .animation(.easeOut)
                                .matchedGeometryEffect(id: self.chosenBill.id, in: namespace)
                                .frame(height: 240)
                            }

                            EntryListView(bill: self.$chosenBill, selectedEntry: self.$selectedEntry, showEntryDetail: self.$showEntryDetail, editingEntry: self.$editingEntry, taxRate: self.chosenBill.taxRate)
                                .opacity(self.showEntries ? Double((self.scrollOffset > 0 ? 1 - self.scrollOffset/self.pullToDismissDistance : 1)) : 0)
                                .animation(.easeOut(duration: animationDuration))
                        }
                        .scaleEffect(self.scrollOffset > 0 ? 1 - (self.scrollOffset/pullToDismissDistance)*0.1 : 1)
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            self.editingEntry = nil
                        }
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

                // MARK: Cancel Button
                if showEntries {
                    VStack {
                        HStack (alignment: .top) {
                            Spacer()
                            Button(action: tapToDismiss) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.gray)
                                    .opacity(0.8)
                            }
                            .opacity(self.scrollOffset > 1 ? 0 : 1)

                        }
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                    .animation(.easeOut)
                }
            }
            .statusBar(hidden: topOffset == 0)
            .sheet(isPresented: self.$showEntryDetail, content: {
                EntryDetailView(parentBill: self.$chosenBill, entryID: $selectedEntry, showSheetView: self.$showEntryDetail)
            })
            .padding(.top, topOffset)
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: 650)
            .onChange(of: self.scrollOffset, perform: { value in
                self.editingEntry = nil
                if value > pullToDismissDistance {
                    if !onRemoving {
                        onRemoving = true
                        haptic_one_click()
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
        BillDetailView(chosenBill: .constant(BillObject.sample[1]), namespace: namespace, dismissBillDetail: {}, animationDuration: 0.3, background: Color.white, topOffset: 0, selectedEntry: .init())
            //            .previewDevice("iPhone 12")
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}
