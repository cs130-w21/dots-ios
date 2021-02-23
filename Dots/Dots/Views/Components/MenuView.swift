//
//  MenuView.swift
//  Dots
//
//  Created by Jack Zhao on 2/3/21.
//

import SwiftUI

struct MenuView: View {
    @Binding var menuOptions: menuOption
    @Binding var state: HomeViewStates
    @Binding var data: DotsData
    
    @State var showClearAlert: Bool = false
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                // Placeholder
                HomeNavbarView(topLeftButtonView: "arrow.backward", topRightButtonView: "", titleString: "", topLeftButtonAction: {
                    withAnimation (.spring()) {
                        self.state = .HOME
                    }
                }, topRightButtonAction: { })
                //                Text("Edit Group")
                //                    .foregroundColor(Color(UIColor.systemGray))
                //                    .font(.title3)
                //                    .bold()
                //
                //                Divider()
                //                    .padding(.horizontal)
                //                LinearDotSubView(selected: self.$group, all: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
                //                    .padding(.horizontal)
                //                    .padding(.top, 10)
                //                    .padding(.bottom, 40)
                
                
                Group {
                    Text("Filter")
                        .foregroundColor(Color(UIColor.systemGray))
                        .font(.title3)
                        .bold()
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.bottom)
                    VStack (spacing: 15) {
                        Button(action: {
                            self.menuOptions.groupByInitiator.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text("Group By Creditor")
                                            .foregroundColor(BubbleFontColor())
                                    } icon: {
                                        if self.menuOptions.groupByInitiator {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                        }
                                        else {
                                            Image(systemName: "star")
                                        }
                                    }
                                    .foregroundColor(BubbleFontColor())
                                )
                        }
                        .foregroundColor(BubbleBackground())
                        
                        Button(action: {
                            self.menuOptions.groupByPaid.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text("Group By Unpaid")
                                            .foregroundColor(BubbleFontColor())
                                    } icon: {
                                        if self.menuOptions.groupByPaid {
                                            Image(systemName: "dollarsign.circle.fill")
                                                .foregroundColor(.gray)
                                        }
                                        else {
                                            Image(systemName: "dollarsign.circle")
                                        }
                                    }
                                    .foregroundColor(BubbleFontColor())
                                )
                        }
                        .foregroundColor(BubbleBackground())
                        .disabled(true)
                        .opacity(0.5)
                        
                        
                        Button(action: {
                            self.menuOptions.hidePaid.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text(self.menuOptions.hidePaid ? "Unhide Paid Bills" : "Hide Paid Bills")
                                            .foregroundColor(BubbleFontColor())
                                    } icon: {
                                        if self.menuOptions.hidePaid {
                                            Image(systemName: "eye.slash.fill")
                                        } else {
                                            Image(systemName: "eye.slash")
                                        }
                                    }
                                    .foregroundColor(BubbleFontColor())
                                )
                            
                        }
                        .foregroundColor(BubbleBackground())
                        
                        
                    }
                    .padding(.bottom, 40)
                }
                
                Group {
                    Text("Preference")
                        .foregroundColor(Color(UIColor.systemGray))
                        .font(.title3)
                        .bold()
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    VStack (spacing: 12) {
                        Button(action: {
                            self.menuOptions.enableFaceId.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text(self.menuOptions.enableFaceId ? "Disable FaceID" : "Enable FaceID")
                                    } icon: {
                                        Image(systemName: "faceid")
                                            .foregroundColor(self.menuOptions.enableFaceId ? .green : BubbleFontColor())
                                    }
                                    .foregroundColor(BubbleFontColor())
                                )
                        }
                        .foregroundColor(BubbleBackground())
                        
                        Button(action: {
                            self.data.markAllBillsAsPaid()
                        }) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text("Mark All As Paid")
                                            .foregroundColor(BubbleFontColor())
                                    } icon: {
                                        Image(systemName: "checkmark.seal").foregroundColor(.blue)
                                    }
                                    .foregroundColor(BubbleFontColor())
                                )
                        }
                        .foregroundColor(BubbleBackground())
                        
                        Button(action: {
                            self.showClearAlert.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text("Clear All Paid")
                                            .foregroundColor(BubbleFontColor())
                                    } icon: {
                                        Image(systemName: "xmark").foregroundColor(.red)
                                    }
                                    .foregroundColor(BubbleFontColor())
                                )
                        }
                        .foregroundColor(BubbleBackground())
                    }
                }
                Spacer()
                
                VStack {
                    Text("Dots - The bill splitter \(versionAndBuildNumber())")
                        .font(.caption2)
                        .foregroundColor(Color(UIColor.systemGray3))
                    
                    Button(action: {}) {
                        Text("Terms of Use")
                            .font(.caption2)
                            .opacity(0.7)
                    }
                    .padding(.top, 2)
                }
                .padding(.top, 120)
            }
            .padding(.horizontal)
        }
        .alert(isPresented: self.$showClearAlert) { () -> Alert in
            if self.data.getPaidBills().count == 0 {
                return Alert(title: Text("You don't have any paid bills"))
            }
            else {
                return Alert(title: Text("Are you sure?"), message: Text("Are you sure you want to remove all \(self.data.getPaidBills().count) paid bills?"), primaryButton: .destructive(Text("Yes"), action: {
                    withAnimation(.spring()) {
                        self.data.clearPaidBills()
                    }
                }), secondaryButton: .cancel(Text("No"), action: {}))
            }
        }
    }
    private func BubbleBackground() -> Color {
        if scheme == .dark {
            return Color(UIColor(rgb: 0x28282B))
        }
        else {
            return Color(UIColor(rgb: 0xF3F2F5))
        }
    }
    
    private func BubbleFontColor() -> Color {
        if scheme == .dark {
            return Color(UIColor(rgb: 0xE5E5E5))
        }
        else {
            return Color(UIColor(rgb: 0x747474))
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
