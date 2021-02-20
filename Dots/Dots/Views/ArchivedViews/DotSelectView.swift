////
////  DotSelectView.swift
////  Dots
////
////  Created by Jack Zhao on 1/13/21.
////
//
//import SwiftUI
//
//struct DotSelectView: View {
//    @Binding var show: Bool
//    var circleRadius: Double
//    @Binding var inGroup: [Int]
//    @State var allDots: [Int]
//    let viewOffset: CGFloat = 80
//    let rotationOffset: Int = 1
//    var body: some View {
//        ZStack {
//            ForEach (0..<self.allDots.count) { i in
//                ZStack {
//                    CircleView(index: i, diameter: self.show ? 40 : 13, hasRing: false, ringStroke: 0)
//                        .opacity(show || self.inGroup.contains(i) ? 1 : 0.1)
//                        .scaleEffect(show ? (inGroup.contains(i) ? 0.6 : 1.1) : 1)
//                        .animation(.spring())
//                        .shadow(radius: 10, x: 5, y:10)
//                    
//                }
//                .frame(width: self.show ? 50 : 13, height: self.show ? 50 : 13, alignment: .center)
//                .background(Color.black.opacity(0.01))
//                .offset(x: self.xOffset(i, show: self.show, amount: self.allDots.count),
//                        y: self.yOffset(i, show: self.show, amount: self.allDots.count))
//                .onTapGesture {
//                    if show {
//                        if inGroup.contains(i) {
//                            inGroup.remove(at: inGroup.firstIndex(of: i)!)
//                        } else {
//                            inGroup.append(i)
//                            inGroup.sort()
//                        }
//                        haptic_one_click()
//                    }
//                }
//                
//            }
//        }
//        .frame(width: CGFloat(2 * circleRadius) * 0.5, height: CGFloat(2 * circleRadius) * 0.5)
//        .background(BasePlate(show: $show, inGroup: $inGroup, circleRadius: circleRadius, viewOffset: viewOffset))
//    }
//    
//    private func xOffset(_ index: Int, show: Bool, amount: Int) -> CGFloat {
//        let slice = CGFloat(2 * Double.pi / Double(amount))
//        let r = show ? circleRadius : 0.3 * circleRadius
//        let i = show ? index + rotationOffset : index
//        return CGFloat(r) * cos(slice * CGFloat(i))
//    }
//    
//    private func yOffset(_ index: Int, show: Bool, amount: Int) -> CGFloat {
//        let slice = CGFloat(2 * Double.pi / Double(amount))
//        let r = show ? circleRadius : 0.3 * circleRadius
//        let i = show ? index + rotationOffset : index
//        return CGFloat(r) * sin(slice * CGFloat(i)) + CGFloat(show ? viewOffset : 0)
//    }
//}
//
//
//struct BasePlate: View {
//    @Binding var show: Bool
//    @Binding var inGroup: [Int]
//    let circleRadius: Double
//    let viewOffset: CGFloat
//    var body: some View {
//        Text("\(self.inGroup.count)")
//            .font(.system(.body, design: .rounded))
//            .bold()
//            .opacity(0.4)
//            .background(
//                BlurBackgroundView(style: .systemMaterial)
//                    .clipShape(Circle())
//                    .frame(width: CGFloat(2 * circleRadius) * 0.5, height: CGFloat(2 * circleRadius) * 0.5)
//                    .shadow(radius: 10, x: 5, y: 10)
//                    .scaleEffect(show ? 0.6 : 1)
//                    .onTapGesture {
//                        withAnimation {
//                            self.show.toggle()
//                            if self.show {
//                                // Only haptic when changing state from 'not show' to 'show'
//                                haptic_one_click()
//                            }
//                        }
//                    }
//            )
//            .offset(y: show ? viewOffset : 0)
//    }
//}
//
//
//struct DotSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        DotSelectView(show: .constant(true), circleRadius: 90, inGroup: .constant([1,2,3]), allDots: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
//            .previewDevice("iPhone 12 mini")
//    }
//}
