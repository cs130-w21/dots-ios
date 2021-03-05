//
//  Helper.swift
//  Dots
//
//  Created by Jack Zhao on 1/9/21.
//

import Foundation
import SwiftUI
import UIKit
// Screen size that is accessible through the entire program
/// Define UI screen bounds.
let screen = UIScreen.main.bounds

/// Define UI colors.
let dotColors: [Color] = [
    Color(UIColor.systemRed),
    Color(UIColor.systemBlue),
    Color(UIColor.systemGreen),
    Color(UIColor.systemIndigo),
    Color(UIColor.systemOrange),
    Color.primary,
    Color(UIColor.systemPurple),
    Color(UIColor.systemTeal),
    Color(UIColor.systemYellow),
    Color(UIColor.systemGray),
]


/// Create one haptic click feedback.
func haptic_one_click() {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
}

/// An extension of `View` to replace `ForEach` but provides an extra index argument in the wrapper.
public struct ForEachWithIndex<Data: RandomAccessCollection, ID: Hashable, Content: View>: View {
    public var data: Data
    public var content: (_ index: Data.Index, _ element: Data.Element) -> Content
    var id: KeyPath<Data.Element, ID>
    
    /// Initialize.
    /// - Parameters:
    ///   - data: an iterable data object.
    ///   - id: identifier.
    ///   - content: content.
    public init(_ data: Data, id: KeyPath<Data.Element, ID>, content: @escaping (_ index: Data.Index, _ element: Data.Element) -> Content) {
        self.data = data
        self.id = id
        self.content = content
    }
    
    /// View builder.
    public var body: some View {
        ForEach(
            zip(self.data.indices, self.data).map { index, element in
                IndexInfo(
                    index: index,
                    id: self.id,
                    element: element
                )
            },
            id: \.elementID
        ) { indexInfo in
            self.content(indexInfo.index, indexInfo.element)
        }
    }
}

extension ForEachWithIndex where ID == Data.Element.ID, Content: View, Data.Element: Identifiable {
    public init(_ data: Data, @ViewBuilder content: @escaping (_ index: Data.Index, _ element: Data.Element) -> Content) {
        self.init(data, id: \.id, content: content)
    }
}

extension ForEachWithIndex: DynamicViewContent where Content: View {
}

private struct IndexInfo<Index, Element, ID: Hashable>: Hashable {
    let index: Index
    let id: KeyPath<Element, ID>
    let element: Element

    var elementID: ID {
        self.element[keyPath: self.id]
    }

    static func == (_ lhs: IndexInfo, _ rhs: IndexInfo) -> Bool {
        lhs.elementID == rhs.elementID
    }

    func hash(into hasher: inout Hasher) {
        self.elementID.hash(into: &hasher)
    }
}

extension View {
    /// Create a view of gradient foreground color.
    /// - Parameter colors: gradient colors.
    /// - Returns: foreground color view.
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}

extension UIColor {
    /// UIColor alternative initializer.
    /// - Parameters:
    ///   - red: red value of RGB.
    ///   - green: green value of RGB.
    ///   - blue: blue value of RGB.
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
    
    /// UIColor alternative initializer.
    /// - Parameter rgb: a hex value of color.
   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

/// Access to the current version and build number.
/// - Returns: a string of version number and build number.
func versionAndBuildNumber() -> String {
    /// Version number.
    let versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    /// Build number.
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    if let versionNumber = versionNumber, let buildNumber = buildNumber {
        return "\(versionNumber) (\(buildNumber))"
    } else if let versionNumber = versionNumber {
        return versionNumber
    } else if let buildNumber = buildNumber {
        return buildNumber
    } else {
        return ""
    }
}

extension Double
{
    /// An extension to `Double` that truncates the value with a specified decimal number.
    /// - Parameter places: number of decimals to keep.
    /// - Returns: a truncated Double value.
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}


