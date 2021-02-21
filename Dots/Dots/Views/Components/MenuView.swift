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
    @Binding var group: [Int]
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
                Text("Edit Group")
                    .foregroundColor(Color(UIColor.systemGray))
                    .font(.title3)
                    .bold()
                    
                Divider()
                    .padding(.horizontal)
                LinearDotSubView(selected: self.$group, all: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                
                
                Group {
                    Text("Utilities")
                        .foregroundColor(Color(UIColor.systemGray))
                        .font(.title3)
                        .bold()
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.bottom)
                    VStack (spacing: 12) {
                        Button(action: {
                            self.menuOptions.groupByInitiator.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text("Group by initiator")
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
                        
                        Button(action: {}) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text("Mark all as paid")
                                            .foregroundColor(BubbleFontColor())
                                    } icon: {
                                        Image(systemName: "checkmark.seal").foregroundColor(.blue)
                                    }
                                    .foregroundColor(BubbleFontColor())
                                )
                        }
                        .foregroundColor(BubbleBackground())
                        
                        Button(action: {
                            self.menuOptions.hidePaid.toggle()
                        }) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text(self.menuOptions.hidePaid ? "Unhide paid bills" : "Hide paid bills")
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
                        
                        Button(action: {}) {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .frame(height: 40)
                                .padding(.horizontal)
                                .overlay(
                                    Label {
                                        Text("Clear all bills")
                                            .foregroundColor(BubbleFontColor())
                                    } icon: {
                                        Image(systemName: "xmark").foregroundColor(.red)
                                    }
                                    .foregroundColor(BubbleFontColor())
                                )
                        }
                        .foregroundColor(BubbleBackground())
                    }
                    .padding(.bottom, 40)
                }
                
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
                }
                Spacer()
                
                VStack {
                    Text("Dots - The bill splitter")
                        .font(.caption2)
                        .foregroundColor(BubbleFontColor())
                    
                    Text("Version 0.6.5")
                        .font(.caption2)
                        .foregroundColor(BubbleFontColor())
                }
                .padding(.vertical, 80)
            }
            .padding(.horizontal)
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
