//
//  LinearDotSelectView.swift
//  Dots
//
//  Created by Jack Zhao on 1/20/21.
//

import SwiftUI

/// A horizontal list of circular icons
struct LinearDotSubView: View {
    /// a list of indices of the selected icons
    @Binding var selected: [Int]
    /// a list of indices of all the icons
    let all: [Int]
    /// default size of an icon
    let dotSize: CGFloat = 35
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(self.all,  id: \.self) { i in
                    CircleView(index: i, diameter: Double(dotSize))
                        .frame(height: dotSize)
                        .padding(.horizontal, 13)
                        .padding(.vertical, 10)
                        .scaleEffect(self.selected.contains(i) ? 0.6 : 1)
                        .shadow(radius: 5)
                        .onTapGesture {
                            withAnimation {
                                if self.selected.contains(i) {
                                    self.selected.remove(at: self.selected.firstIndex(of: i)!)
                                }
                                else {
                                    self.selected.append(i)
                                    self.selected.sort()
                                }
                            }
                            haptic_one_click()
                        }
                }
            }
            .padding(.horizontal, dotSize)
        }
        .background(Color(UIColor.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 40.0))
    }
}


struct LinearDotSelectView_Previews: PreviewProvider {
    static var previews: some View {
        LinearDotSubView(selected: .constant([8]), all: [8,1, 0, 2, 4, 5])
            .previewLayout(.sizeThatFits)
    }
}

