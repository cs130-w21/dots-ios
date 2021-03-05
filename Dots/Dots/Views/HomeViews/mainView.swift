//
//  mainView.swift
//  Dots
//
//  Created by Jack Zhao on 2/17/21.
//


import SwiftUI

/// Define the states of the homeview.
enum HomeViewStates {
    /// Home state.
    case HOME
    /// Setting state.
    case SETTING
    /// Settle bill state.
    case SETTLE
}

/// Define the filter type that can be choose by user.
enum FilterType {
    /// Default filter.
    case Default
    /// Creditor prioritized.
    case Creditor
    /// Unpaid bill prioritized.
    case Paid
    /// Sort by unpaid bills first then creditor.
    case CreditorAndPaid
}

/// Main view.
struct mainView: View {
    /// Stores all datas dots data objects.
    @Binding var data: DotsData
    /// Authenticator.
    @Binding var authenticator: Authenticator
    /// Store options the user choose.
    @Binding var menuOption: menuOption
    
    /// Set the state for homeview state.
    @State var state: HomeViewStates = .HOME
    
    /// Set the filter types to default.
    @State var filter: FilterType = .Default
    
    /// Stores the UUID of current bill that is being edited.
    @State var editing: UUID? = nil
    
    // Bill transition
    
    /// Stores the information of the selected bill.
    @State var chosenBill: Int? = nil
    
    /// This value is true when `BillDetailView` is active.
    @State var fullView: Bool = false
    
    /// Disable other card views from gesture control when one card is animating.
    @State var isDisabled: Bool = false
    
    /// Stores the bill whose Z Index must be prioritized to prevent overlapped by other card views. Usually the selected bill.
    @State var zIndexPriority: BillObject? = nil
    
    /// Animation namespace.
    @Namespace var namespace
    
    /// Animation duration time.
    @State var animationDuration: Double = 0.3
    
    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
    
    /// Set the view size.
    @State var ViewSize: CGSize = .zero
    //    let sideBarWidth: CGFloat = screen.width > 450 ? 400 : 0.85 * screen.width
    
    
    /// A boolean value indicating whether show the bill detail sheet or not.
    @State var showBillDetailSheet: Bool = false
    
    /// Stores the uuid for the target bill.
    @State var targetBill: UUID? = nil
    
    /// Store the settle results.
    @State var settleResult: [Int: [(Int, Double)]] = [:]
    
    /// Main View.
    var body: some View {
        ZStack {
            primaryBackgroundColor()
                .ignoresSafeArea()
            
            GeometryReader { geo in
                HStack (spacing: 0) {
                    
                    MenuView(menuOptions: self.$menuOption, state: self.$state, data: self.$data, authenticator: self.$authenticator)
                        .frame(width: getSideBarWidth())
                    
                    // Middle View
                    ZStack {
                        ScrollView (.vertical, showsIndicators: false) {
                            HomeNavbarView(topLeftButtonView: "line.horizontal.3", topRightButtonView: "plus", titleString: "Your Bills", topLeftButtonAction: {
                                withAnimation (.spring()) {
                                    self.state = .SETTING
                                }
                            }, topRightButtonAction: {
                                withAnimation (.spring()) {
                                    self.showBillDetailSheet.toggle()
                                }
                            })
                            
                            Divider()
                                .padding(.horizontal)
                                .padding(.bottom)
                            
                            if (self.data.getUnpaidBills().count > 2) {
                                NotificationBubble(message: "You have \(self.data.getUnpaidBills().count) unsettled bills, ", actionPrompt: "settle now!", action: {
                                    withAnimation {
                                        self.state = .SETTLE
                                    }
                                })
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                            
                            ZStack {
                                if self.data.bills.count > 0 && !self.menuOption.hidePaid || self.data.getUnpaidBills().count > 0 {
                                    LazyVGrid (columns: [GridItem(.adaptive(minimum: 270), spacing: 30)], spacing: 30) {
                                        ForEachWithIndex(self.data.bills) { index, bill in
                                            if self.menuOption.hidePaid && !bill.paid || !self.menuOption.hidePaid {
                                                
                                                CardRowView(bill: bill, editing: self.$editing, namespace: namespace, activeBillDetail: {
                                                    activeBillDetail(id: bill.id)
                                                }, deleteAction: {
                                                    self.data.bills.remove(at: index)
                                                }
                                                , secondaryAction: {
                                                    self.targetBill = bill.id
                                                    self.showBillDetailSheet.toggle()
                                                })
                                                .matchedGeometryEffect(id: bill.id, in: namespace)
                                                .frame(height: 140)
                                                .zIndex(zIndexPriority == bill ? 1 : 0)
                                                .disabled(isDisabled)
                                                .accessibility(identifier: "\(bill.title)-\(index)")
                                            }
                                        }
                                    }
                                    
                                }
                                else if self.menuOption.hidePaid && self.data.getPaidBills().count > 0 {
                                    VStack {
                                        Spacer()
                                        Text("No Unpaid Bills")
                                            .font(.system(.title2, design: .rounded))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 4)
                                        Text("\(self.data.getPaidBills().count) \(self.data.getPaidBills().count > 1 ? " bills are" : " bill is") hidden.")
                                            .font(.system(.headline, design: .rounded))
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    .frame(height: 0.6 * geo.size.height)
                                }
                                else {
                                    VStack {
                                        Spacer()
                                        Text("No Bills")
                                            .font(.system(.title2, design: .rounded))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    .frame(height: 0.6 * geo.size.height)
                                }
                                
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 90)
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.editing = nil
                            }
                        }
                        .frame(height: geo.size.height)
                        
                        HomeBottomView(buttonText: "Calculate", secondaryButtonText: self.menuOption.hidePaid ? "Unhide Paid Bills" : "Hide Paid Bills", confirmFunc: {
                            withAnimation(.spring()) {
                                self.state = .SETTLE
                            }
                        }, secondaryFunc: {
                            withAnimation(.spring()) {
                                self.menuOption.hidePaid.toggle()
                            }
                        }, backgroundColor: primaryBackgroundColor())
                        
                    }
                    .sheet(isPresented: self.$showBillDetailSheet, content: {
                        AddBillView(showSheetView: self.$showBillDetailSheet, billList: self.$data.bills, group: self.data.group, workingOn: self.$targetBill)
                    })
                    .frame(width: geo.size.width)
                    .disabled(middleViewDisabled())
                    .onTapGesture {
                        if middleViewDisabled() {
                            withAnimation(.spring()) {
                                self.state = .HOME
                            }
                        }
                    }
                    
                    
                    // Settle bill view
                    ScrollView (.vertical, showsIndicators: false) {
                        VStack {
                            HomeNavbarView(topLeftButtonView: "", topRightButtonView: "arrow.left", titleString: "Payment list", topLeftButtonAction: {}, topRightButtonAction: {
                                withAnimation(.spring()) {
                                    self.state = .HOME
                                }
                            })
                            Divider()
                                .padding(.horizontal)
                            VStack (spacing: 16){
                                if Array(self.settleResult.keys).count == 0 {
                                    NotificationBubble(message: "No balance information available.", actionPrompt: "", action: {})
                                }
                                else {
                                    ForEach(Array(self.settleResult.keys), id: \.self) { key in
                                        SettleCardView(creditor: key, amount: self.data.getMemberTotal(member: key), debtors: self.settleResult[key]!, background: BubbleBackground())
                                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                    }
                                }
                                if self.data.getUnpaidBills().count > 0 {
                                    NotificationBubble(message: "Mark \(self.data.getUnpaidBills().count) \(self.data.getUnpaidBills().count > 1 ? "bills" : "bill") as ", actionPrompt: "paid", action: {
                                        self.data.markAllBillsAsPaid()
                                    })
                                }
                            }
                            .padding()
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .frame(width: getSideBarWidth())
                }
                .onAppear {
                    ViewSize = geo.size
                }
                .onChange(of: geo.size) { _ in
                    ViewSize = geo.size
                }
            }
            .offset(getHomeViewOffset())
            // MARK: Bill detail view
            if self.fullView && self.chosenBill != nil {
                BillDetailView(chosenBill: self.$data.bills[chosenBill!], namespace: namespace, dismissBillDetail: dismissBillDetail, animationDuration: self.animationDuration, background: primaryBackgroundColor(), topOffset: ViewSize.width > 450 ? 55 : 0)
                    .onDisappear {
                        self.settleResult = self.data.calculate_settlement()
                        self.data.bills.append(.init())
                        self.data.bills.removeLast()
                    }
                
            }
        }
        .onAppear {
            self.settleResult = self.data.calculate_settlement()
            //            print("Changed on main appear")
        }
        .onChange(of: self.data.bills) {_ in
            self.settleResult = self.data.calculate_settlement()
            withAnimation(.spring()) {
                self.data.smartSort(filter: self.filter)
            }
        }
        .onChange(of: self.menuOption) {_ in
//            var groupByInitiator: Bool = false
//            var groupByPaid: Bool = false
//            var hidePaid: Bool = false
//            var enableFaceId: Bool = false
            if self.menuOption.groupByInitiator && self.menuOption.groupByPaid {
                self.filter = .CreditorAndPaid
            } else if self.menuOption.groupByPaid {
                self.filter = .Paid
            } else if self.menuOption.groupByInitiator {
                self.filter = .Creditor
            } else {
                self.filter = .Default
            }
            self.authenticator.enableAuthentication = self.menuOption.enableFaceId
            withAnimation(.spring()) {
                self.data.smartSort(filter: self.filter)
            }
        }
    }
    
    private func getSideBarWidth() -> CGFloat {
        return ViewSize.width > 450 ? 400 : 0.85 * ViewSize.width
    }
    
    private func getHomeViewOffset() -> CGSize {
        switch self.state {
        case .HOME:
            return CGSize(width: -(self.getSideBarWidth()), height: 0)
            
        case .SETTING:
            return CGSize.zero
            
        case .SETTLE:
            return CGSize(width: -(2 * self.getSideBarWidth()), height: 0)
        }
    }
    private func middleViewDisabled() -> Bool {
        return self.state != .HOME
    }
    
    private func primaryBackgroundColor() -> Color {
        if scheme == .dark {
            return Color.black
        }
        else {
            return Color(UIColor(rgb: 0xFCFCFF))
        }
    }
    
    /// A series of actions to active a `BillDetailView`.
    /// - Parameter bill: target bill object.
    private func activeBillDetail(id: UUID) {
        guard let targetIndex = self.data.getBillIndexByUUID(id: id) else {
            fatalError("Cannot find bill by uuid!!")
        }
        withAnimation {
            fullView.toggle()
            chosenBill = targetIndex
        }
        zIndexPriority = self.data.bills[chosenBill!]
        isDisabled = true
        haptic_one_click()
    }
    
    private func deleteBill(bill: BillObject) -> Int? {
        //        print("Remove bill: \(bill.entries.count) entries")
        let index = self.data.bills.firstIndex(of: bill)
        if index != nil && index! < self.data.bills.count {
            self.data.bills.remove(at: index!)
        }
        return index
    }
    
    /// A series of actions when the `BillDetailView` is deactivated.
    private func dismissBillDetail () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            isDisabled = false
            zIndexPriority = nil
        })
        fullView = false
        self.chosenBill = nil
    }
    
    
    /// Add a bill at given index.
    /// - Parameters:
    ///   - at: insert at index.
    ///   - bill: target bill.
    private func addBill (at: Int, bill: BillObject) {
        self.data.bills.insert(bill, at: at)
        //        print("Add bill: \(bill.entries.count) entries")
    }
    
    
    /// A manual binding function. Often used in `ForEach` loop.
    /// - Parameter bill: `BillObjet` that cannot use binding naturally.
    /// - Returns: A binding object of the bill.
    private func binding(for bill: BillObject) -> Binding<BillObject> {
        guard let billIndex = self.data.bills.firstIndex(where: { $0.id == bill.id }) else {
            fatalError("Can't find scrum in array")
        }
        
        return self.$data.bills[billIndex]
    }
    
    private func BubbleBackground() -> Color {
        if scheme == .dark {
            return Color(UIColor(rgb: 0x28282B))
        }
        else {
            return Color(UIColor(rgb: 0xF3F2F5))
        }
    }
    //
    //    private func BubbleFontColor() -> Color {
    //        if scheme == .dark {
    //            return Color(UIColor(rgb: 0xE5E5E5))
    //        }
    //        else {
    //            return Color(UIColor(rgb: 0x747474))
    //        }
    //    }
}

//struct mainView_Previews: PreviewProvider {
//    static var previews: some View {
//        mainView(data: .constant(.sample))
//            .previewDevice("iPhone 11")
//    }
//}
