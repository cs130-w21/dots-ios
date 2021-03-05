//
//  Special.swift
//  Dots
//
//  Created by Jack Zhao on 1/20/21.
//

import SwiftUI

/// Color scheme delegate.
struct colorScehemeDelegate {
    /// Deprecated: selection of the color scheme.
    let schemeSelection: Int = 0
    /// Primary background color.
    let primaryBackGround: Color
    /// Secondary background color.
    let secondaryBackGround: Color
    /// Primary text color.
    let primaryTextColor: Color
    /// Button background color.
    let buttonBackground: AnyView
    /// Highlight text color.
    let highlightText: Color
    /// Dot colors.
    let dotColors: [Color]
    /// Card colors.
    let cardColors: [AnyView]
    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
}

/// Stores the classic color scheme values.
let classic = colorScehemeDelegate(
    primaryBackGround: Color(UIColor.systemGray6),
    secondaryBackGround: Color(UIColor.systemBackground),
    primaryTextColor: Color(UIColor(rgb: 0x3A3A3C)),
    buttonBackground: AnyView(Color.blue),
    highlightText: Color.blue,
    dotColors:     [
        Color(UIColor.systemYellow),
        Color(UIColor.systemOrange),
        Color(UIColor.systemRed),
        Color(UIColor(rgb: 0xFA85BD)),
        Color(UIColor.systemPurple),
        Color(UIColor(rgb: 0x045EAE)),
        Color(UIColor.systemBlue),
        Color(UIColor.systemTeal),
        Color(UIColor.systemGreen),
        Color(UIColor.systemGray)],
    cardColors: []
)


