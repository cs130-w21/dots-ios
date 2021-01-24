//
//  Special.swift
//  Dots
//
//  Created by Jack Zhao on 1/20/21.
//

import SwiftUI

struct colorScehemeDelegate {
    let schemeSelection: Int = 0
    let primaryBackGround: Color
    let secondaryBackGround: Color
    let primaryTextColor: Color
    let buttonBackground: AnyView
    let highlightText: Color
    let dotColors: [Color]
    let cardColors: [AnyView]
}

let classic = colorScehemeDelegate(
    primaryBackGround: Color(UIColor.systemGray6),
    secondaryBackGround: Color(UIColor.systemBackground),
    primaryTextColor: Color(UIColor(rgb: 0x3A3A3C)),
    buttonBackground: AnyView(Color.blue),
    highlightText: Color.blue,
    dotColors:     [Color(UIColor.systemRed),
                    Color(UIColor.systemBlue),
                    Color(UIColor.systemGreen),
                    Color(UIColor.systemIndigo),
                    Color(UIColor.systemOrange),
                    Color.primary,
                    Color(UIColor.systemPurple),
                    Color(UIColor.systemTeal),
                    Color(UIColor.systemYellow),
                    Color(UIColor.systemGray)],
    cardColors: []
)
//
//let carina: colorScehemeDelegate = colorScehemeDelegate(
//    primaryBackGround: Color(UIColor.systemBackground),
//    secondaryBackGround: Color(UIColor.systemGray6),
//    primaryTextColor: Color(UIColor(hex: "#3A3A3CF")!),
//    buttonBackground: AnyView(LinearGradient(gradient: Gradient(colors: [Color(UIColor(hex: "#7EF192F")!), Color(UIColor(hex: "#2DC897F")!)]), startPoint: .bottomLeading, endPoint: .topTrailing)),
//    highlightText: Color.green,
//    dotColors: [Color(UIColor(hex: "#D9504DF")!),
//                Color(UIColor(hex: "#4AA8FFF")!),
//                Color(UIColor(hex: "#BEEA60F")!),
//                Color(UIColor(hex: "#6CB052F")!),
//                Color(UIColor(hex: "#FFA564F")!),
//                Color(UIColor(hex: "#FFBBCFF")!),
//                Color(UIColor(hex: "#764899F")!),
//                Color(UIColor(hex: "#587CCDF")!),
//                Color(UIColor(hex: "#FBF2A8F")!),
//                Color(UIColor(hex: "#8F8C8CF")!)],
//    cardColors: []
//)
