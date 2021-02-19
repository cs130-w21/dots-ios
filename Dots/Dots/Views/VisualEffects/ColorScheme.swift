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
