//
//  mainView.swift
//  Dots
//
//  Created by Jack Zhao on 2/17/21.
//


import SwiftUI

enum HomeViewStates {
    case HOME
    case SETTING
    case SETTLE
}

struct mainView: View {
    @Binding var data: DotsData
    @State var state: HomeViewStates = .HOME

    /// Stores the UUID of current bill that is being edited.
    @State var editing: UUID? = nil

    // Bill transition

    /// Stores the information of the selected bill
    @State var chosenBill: Int? = nil

    /// This value is true when `BillDetailView` is active
    @State var fullView: Bool = false

    /// Disable other card views from gesture control when one card is animating
    @State var isDisabled: Bool = false

    /// Stores the bill whose Z Index must be prioritized to prevent overlapped by other card views. Usually the selected bill.
    @State var zIndexPriority: BillObject? = nil

    /// Animation namespace
    @Namespace var namespace

    /// Animation duration time.
    @State var animationDuration: Double = 0.3

    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme

    @State var ViewSize: CGSize = .zero
//    let sideBarWidth: CGFloat = screen.width > 450 ? 400 : 0.85 * screen.width
    @State var menuOption: menuOption = .init()

    @State var showBillDetailSheet: Bool = false
    @State var targetBill: UUID? = nil

    @State var settleResult: [Int: [(Int, Double)]] = [:]

    /// Home View
    var body: some View {
        ZStack {
            primaryBackgroundColor()
                .ignoresSafeArea()

            GeometryReader { geo in
                HStack (spacing: 0) {

                    MenuView(menuOptions: self.$menuOption, state: self.$state, group: self.$data.group)
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


                            if (self.data.getUnpaidBills().count > 2) {
                                NotificationBubble(message: "You have \(self.data.getUnpaidBills().count) unsettled bills, ", actionPrompt: "settle now!", action: {
                                    withAnimation {
                                        self.state = .SETTLE
                                    }
                                })
                                .padding()
                            }

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
                                    }
                                }

                            }
                            .padding(.horizontal, 20)
                            .padding(.bottom, 50)
                        }
                        .onTapGesture {
                            withAnimation(.spring()) {
                                self.editing = nil
                            }
                        }

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
                        HomeNavbarView(topLeftButtonView: "", topRightButtonView: "arrow.left", titleString: "Settle bills", topLeftButtonAction: {}, topRightButtonAction: {
                            self.state = .HOME
                        })
                        Divider()
                        VStack (spacing: 16){
                            ForEach(Array(self.settleResult.keys), id: \.self) { key in
                                SettleCardView(creditor: key, amount: self.data.getMemberTotal(member: key), debtors: self.settleResult[key]!, background: BubbleBackground())
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            }
                        }
                        .padding()
                        Spacer()
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
//            print("Changed onChnge of list bills")
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

    /// A series of actions to active a `BillDetailView`
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

    /// A series of actions when the `BillDetailView` is deactivated
    private func dismissBillDetail () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            isDisabled = false
            zIndexPriority = nil
        })
        fullView = false
        self.chosenBill = nil
    }


    /// Add a bill at given index
    /// - Parameters:
    ///   - at: insert at index
    ///   - bill: target bill
    private func addBill (at: Int, bill: BillObject) {
        self.data.bills.insert(bill, at: at)
//        print("Add bill: \(bill.entries.count) entries")
    }


    /// A manual binding function. Often used in `ForEach` loop.
    /// - Parameter bill: `BillObjet` that cannot use binding naturally.
    /// - Returns: A binding object of the bill
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

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        mainView(data: .constant(.sample))
            .previewDevice("iPhone 11")
    }
}
