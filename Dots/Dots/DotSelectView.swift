//
//  DotSelectView.swift
//  Dots
//
//  Created by Jack Zhao on 1/13/21.
//

import SwiftUI

struct DotSelectView: View {
    @Binding var show: Bool
    var circleRadius: Double
    @Binding var inGroup: [Int]
    @State var allDots: [Int]
//    let totalCount: Int
    
    var body: some View {
        ZStack {
            ZStack{
                Circle()
                    .foregroundColor(Color(UIColor.systemBackground))
                    .frame(width: CGFloat(2 * circleRadius) * 0.5, height: CGFloat(2 * circleRadius) * 0.5)
                    .shadow(radius: 10, x: 5, y: 10)
                    .scaleEffect(show ? 0.6 : 1)
                    .onTapGesture {
                        withAnimation {
                            self.show.toggle()
                            haptic_one_click()
                        }
                    }
                Text("\(self.inGroup.count)")
                    .font(.system(.body, design: .rounded))
                    .bold()
                    .opacity(0.4)
            }
            .offset(y: show ? 80 : 0)
            
            
            ForEach (0..<self.allDots.count) { i in
                CircleView(index: i, diameter: self.show ? 40 : 13, hasRing: false, ringStroke: 0)
                    .opacity(show || self.inGroup.contains(i) ? 1 : 0.1)
                    .scaleEffect(show ? (inGroup.contains(i) ? 0.6 : 1.1) : 1)
                    .animation(.spring())
                    .shadow(radius: 10, x: 5, y:10)
                    .offset(x: self.xOffset(i, show: self.show, amount: self.allDots.count),
                            y: self.yOffset(i, show: self.show, amount: self.allDots.count))
                    .onTapGesture {
                        if show {
                            if inGroup.contains(i) {
                                inGroup.remove(at: inGroup.firstIndex(of: i)!)
                            } else {
                                inGroup.append(i)
                                inGroup.sort()
                            }
                            haptic_one_click()
                        }
                        
                    }
            }
            
        }
    }
    
    private func xOffset(_ index: Int, show: Bool, amount: Int) -> CGFloat {
        let slice = CGFloat(2 * Double.pi / Double(amount))
        let r = show ? circleRadius : 0.3 * circleRadius
        let i = show ? index + 1 : index
        return CGFloat(r) * cos(slice * CGFloat(i))
    }
    
    private func yOffset(_ index: Int, show: Bool, amount: Int) -> CGFloat {
        let slice = CGFloat(2 * Double.pi / Double(amount))
        let r = show ? circleRadius : 0.3 * circleRadius
        let i = show ? index + 1 : index
        return CGFloat(r) * sin(slice * CGFloat(i)) + CGFloat(show ? 80 : 0)
    }
}

struct DotSelectView_Previews: PreviewProvider {
    static var previews: some View {
        DotSelectView(show: .constant(true), circleRadius: 90, inGroup: .constant([1,2,3]), allDots: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
            .previewDevice("iPhone 12 mini")
    }
}
