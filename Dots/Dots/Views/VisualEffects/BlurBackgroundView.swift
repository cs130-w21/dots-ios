//
//  BlurBackgroundView.swift
//  Dots
//
//  Created by Jack Zhao on 1/20/21.
//

import SwiftUI
//
/// A transluctent blured background view.
struct BlurBackgroundView: UIViewRepresentable {
    typealias UIViewType = UIView
    /// Blur style.
    var style: UIBlurEffect.Style
    
    /// Create the UI View.
    /// - Parameter context: context.
    /// - Returns: a UI View.
    func makeUIView(context: UIViewRepresentableContext<BlurBackgroundView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        return view
    }
    
    /// Update the UI View.
    /// - Parameters:
    ///   - uiView: UI View.
    ///   - context: context.
    func updateUIView(_ uiView: UIView, context:
                        UIViewRepresentableContext<BlurBackgroundView>) {
        
    }
}
