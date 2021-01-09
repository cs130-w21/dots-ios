//
//  DotObject.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation
import SwiftUI

struct DotObject: Identifiable, Hashable {
    var id = UUID()
    var color: Color
    var isTapped: Bool
    init(color: Color, isTapped: Bool = false) {
        self.color = color
        self.isTapped = isTapped
    }
}

//struct DotsDelegate {
//    var dots: [DotObject] = []
//    var participants: [Int]
//    var initiator: Int
//    
//    init (initiator: Int, participants: [Int]) {
//        self.initiator = initiator
//        self.participants = participants
//        self.dotsInit()
//    }
//    
//    private mutating func dotsInit() {
//        for i in 0 ..< 10 {
//            dots.append(DotObject(color: dotColors[i], isTapped: false))
//        }
//    }
//}
