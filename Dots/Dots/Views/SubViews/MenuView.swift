//
//  MenuView.swift
//  Dots
//
//  Created by Jack Zhao on 2/3/21.
//

import SwiftUI
import LocalAuthentication

/// Menu view.
struct MenuView: View {
    /// Store menu options.
    @Binding var menuOptions: menuOption
    /// Store home view states.
    @Binding var state: HomeViewStates
    /// Store data information as object.
    @Binding var data: DotsData
    /// Authenticator.
    @Binding var authenticator: Authenticator
    
    /// Boolean value that decides to show alert.
    @State var showClearAlert: Bool = false
    
    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
    
    /// Menu body view.
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
                        .accessibility(identifier: "menuGroupByInitiator")
                        // MARK: Removed Menu filter
//                        Button(action: {
//                            self.menuOptions.groupByPaid.toggle()
//                        }) {
//                            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                                .frame(height: 40)
//                                .padding(.horizontal)
//                                .overlay(
//                                    Label {
//                                        Text("Group By Unpaid")
//                                            .foregroundColor(BubbleFontColor())
//                                    } icon: {
//                                        if self.menuOptions.groupByPaid {
//                                            Image(systemName: "dollarsign.circle.fill")
//                                                .foregroundColor(.gray)
//                                        }
//                                        else {
//                                            Image(systemName: "dollarsign.circle")
//                                        }
//                                    }
//                                    .foregroundColor(BubbleFontColor())
//                                )
//                        }
//                        .foregroundColor(BubbleBackground())
//                        .disabled(true)
//                        .opacity(0.5)
                        
                        
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
                        .accessibility(identifier: "menuHide")
                        
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
                        if self.authenticator.biometricType() != .none {
                            Button(action: {
                                testAuthenticate()
                                self.authenticator.unlock()
                            }) {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .frame(height: 40)
                                    .padding(.horizontal)
                                    .overlay(
                                        Label {
                                            Text("\(self.menuOptions.enableFaceId ? "Disable" : "Enable") \(self.authenticator.biometricType() == .faceID ? "FaceID" : "Touch ID")")
                                        } icon: {
                                            Image(systemName: "\(self.authenticator.biometricType() == .faceID ? "faceid" : "touchid")")
                                                .foregroundColor(self.menuOptions.enableFaceId ? .blue : BubbleFontColor())
                                        }
                                        .foregroundColor(BubbleFontColor())
                                    )
                            }
                            .foregroundColor(BubbleBackground())
                            .accessibility(identifier: "menuEnableBiometric")
                        }
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
                        .accessibility(identifier: "menuMarkAllAsPaid")
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
                        .accessibility(identifier: "menuClearAllPaid")
                    }
                }
                Spacer()
                
                VStack {
                    Text("Dots - The Bill Splitter")
                        .font(.caption2)
                        .foregroundColor(Color(UIColor.systemGray3))
                    
                    Text("version \(versionAndBuildNumber())")
                        .font(.caption2)
                        .foregroundColor(Color(UIColor.systemGray3))
                }
                .padding(.top, 0.3 * screen.height)
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
    
    private func testAuthenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.menuOptions.enableFaceId.toggle()
                        print("test success")
                    } else {
                        // error
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
}

//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
