////
////  HomeView.swift
////  Dots
////
////  Created by Jack Zhao on 1/11/21.
////
//
//import SwiftUI
//
//struct HomeView: View {
//    @Binding var groups: [Int]
//    @Binding var bills: [BillObject]
//    
//    //    @State var showDots: Bool = false
//    @State var chosenBill: BillObject? = nil
//    @State var fullView: Bool = false
//    @State var isDisabled: Bool = false
//    @State var zIndexPriority: BillObject? = nil
//    
//    @Namespace var namespace
//    @State var animationDuration: Double = 0.3
//    @State var pressed: Bool = false
//    @State var pressingCard: BillObject? = nil
//    let pressScaleFactor: CGFloat = 0.95
//    
//    @State var showAddBill: Bool = false
//    
//    var body: some View {
//        ZStack {
//            // MARK: Background Color
//            // Light mode: white
//            // Dark mode: black
//            Color(UIColor(rgb: 0xFCFCFF))
//                .ignoresSafeArea()
//            
//            // MARK: Main screen scroll
//            ScrollView (.vertical, showsIndicators: false) {
//                HomeNavbarView(menuAction: {}, addAction: {})
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 270), spacing: 30)], spacing: 30) {
//                    ForEach(self.bills) { bill in
//                        CardItem(card: bill)
//                            .scaleEffect(self.pressed && self.pressingCard == bill ? self.pressScaleFactor : 1)
//                            .matchedGeometryEffect(id: bill.id, in: namespace)
//                            .frame(height: 140)
//                            .zIndex(zIndexPriority == nil ? 0 : (zIndexPriority == bill ? 1 : 0))
//                            .disabled(isDisabled)
//                            .onTapGesture { activeBillDetail(bill: bill) }
//                            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity,
//                                                pressing: { pressing in
//                                                    withAnimation(.easeInOut(duration: 0.2)) {
//                                                        self.pressed = pressing
//                                                        self.pressingCard = bill
//                                                    }
//                                                }, perform: { self.pressingCard = nil })
//                        
//                    }
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.top, 25)
//                .padding(.horizontal)
//                .padding(.bottom, 170)
//            }
//            
//            // MARK: Top Edge Blur
//            TopEdgeBlur()
//            
////            // MARK: Bottom Button tabs
////            HomeBottomView(buttonText: "Add Bill", alternativeText: "show completed", confirmFunc: addBill, alternativeFunc: completeBillToggle)
////                .animation(.spring())
////                .offset(y: fullView ? 250 : 0)
////                .sheet(isPresented: self.$showAddBill) {
////                    AddBillView(billList: self.$bills, group: self.groups, showSheetView: self.$showAddBill)
////                }
//            
//            // MARK: Bill detail view
//            ZStack {
//                if self.fullView && self.chosenBill != nil {
//                    BillDetailView(chosenBill: binding(for: self.chosenBill!), namespace: namespace, dismissBillDetail: dismissBillDetail, animationDuration: self.animationDuration)
//                }
//            }
//            
//        }
//    }
//
//    
//    private func activeBillDetail(bill: BillObject) {
//        withAnimation {
//            fullView.toggle()
//            chosenBill = bill
//        }
//        zIndexPriority = bill
//        isDisabled = true
//        haptic_one_click()
//    }
//    
//    private func dismissBillDetail () {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//            isDisabled = false
//            zIndexPriority = nil
//        })
//        fullView = false
//        self.chosenBill = nil
//    }
//    
//    private func addBill () {
//        self.showAddBill.toggle()
//    }
//    
//    private func completeBillToggle() {
//        
//    }
//    
//    private func binding(for bill: BillObject) -> Binding<BillObject> {
//        guard let billIndex = bills.firstIndex(where: { $0.id == bill.id }) else {
//            fatalError("Can't find scrum in array")
//        }
//        return $bills[billIndex]
//    }
//}
//
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(groups: .constant([1,2,3,4,5]), bills: .constant(BillObject.sample))
//            .preferredColorScheme(.light)
//            .previewDevice("iPhone 11")
//    }
//}
//
//
//
//
