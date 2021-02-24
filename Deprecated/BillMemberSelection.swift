////
////  BillMemberSelection.swift
////  Dots
////
////  Created by Jack Zhao on 2/6/21.
////
//
//import SwiftUI
//
///// Displays responsibility for members in a group in current bill.
//struct BillMemberSelection: View {
//    /// members selected
//    @Binding var selectedGroup: [Int]
//    /// members not selected
//    @State var unselectedGroup: [Int]
//    /// initiator of current bill
//    @Binding var initiator: Int
//    @State var showMiddlePrompt: Bool = false
//    /// default radius of a selected icon
//    let selectedDotsRadius: CGFloat = 80
//    
//    @Namespace var namespace
//    let rotationOffset: Int = 1
//    /// default radius of an icon
//    let circleRadius: Double = 35
//    
//    
//    var body: some View {
//        ZStack {
//            ForEachWithIndex(self.unselectedGroup, id: \.self) { i, attendee in
//                CircleView(index: attendee, diameter: circleRadius)
//                    .scaleEffect(self.selectedGroup.contains(attendee) ? 0.6 : 1)
//                    .offset(y: -selectedDotsRadius)
//                    .rotationEffect(Angle(degrees: Double(i) * 360.0/Double(self.unselectedGroup.count)))
//                    .matchedGeometryEffect(id: attendee, in: namespace)
//                    .onTapGesture {
//                        withAnimation {
//                            if self.selectedGroup.contains(attendee) {
//                                self.selectedGroup.remove(at: self.selectedGroup.firstIndex(of: attendee)!)
//                            } else {
//                                self.selectedGroup.append(attendee)
//                                self.selectedGroup.sort()
//                            }
//                            haptic_one_click()
//                        }
//                    }
//                    .onLongPressGesture() {
//                        self.initiator = attendee
//                        if !self.selectedGroup.contains(attendee) {
//                            self.selectedGroup.append(attendee)
//                            self.selectedGroup.sort()
//                        }
//                    }
//            }
//            
//            if (showMiddlePrompt) {
//                if self.initiator != -1 {
//                    CircleView(index: self.initiator, diameter: Double(selectedDotsRadius))
////                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [15], dashPhase: 1))
////                        .frame(width: selectedDotsRadius, height: selectedDotsRadius)
//                    
//                } else {
//                    Circle()
//                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [15], dashPhase: 1))
//                        .foregroundColor(Color(UIColor.systemGray))
//                        .frame(width: selectedDotsRadius, height: selectedDotsRadius)
//                        .overlay(
//                            Text("Drag initiator here")
//                                .font(.subheadline)
//                                .fontWeight(.regular)
//                                .multilineTextAlignment(.center)
//                                .foregroundColor(Color(UIColor.systemGray))
//                        )
//                }
//            }
//        }
//        .frame(width: 2 * selectedDotsRadius + selectedDotsRadius, height: 2 * selectedDotsRadius + selectedDotsRadius)
//        
//    }
//    
//    private func xOffset(_ index: Int, show: Bool, amount: Int) -> CGFloat {
//        let slice = CGFloat(2 * Double.pi / Double(amount))
//        let r = show ? circleRadius : 0.3 * circleRadius
//        let i = index
//        return CGFloat(r) * cos(slice * CGFloat(i))
//    }
//    
//    private func yOffset(_ index: Int, show: Bool, amount: Int) -> CGFloat {
//        let slice = CGFloat(2 * Double.pi / Double(amount))
//        let r = circleRadius
//        let i = index
//        return CGFloat(r) * sin(slice * CGFloat(i))
//    }
//}
//
//struct BillMemberSelection_Previews: PreviewProvider {
//    static var previews: some View {
//        BillMemberSelection(selectedGroup: .constant([3]), unselectedGroup: [1, 2, 3, 4], initiator: .constant(0))
//    }
//}
