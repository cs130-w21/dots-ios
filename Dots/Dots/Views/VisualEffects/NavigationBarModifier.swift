//
//  NavigationBarModifier.swift
//  Dots
//
//  Created by Jack Zhao on 2/19/21.
//

import SwiftUI

/// Navigation bar modifier view.
struct NavigationBarModifier: ViewModifier {
    
    /// Background color.
    var backgroundColor: UIColor?
    
    /// Initialzer.
    /// - Parameter backgroundColor: background color of the navigation bar.
    init( backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    /// View builder.
    /// - Parameter content: navigation view content.
    /// - Returns: navigation bar view.
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {
    
    /// Modifies the navigation bar color.
    /// - Parameter backgroundColor: background color.
    /// - Returns: a view.
    func navigationBarColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }

}

