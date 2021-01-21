//
//  BlurBackgroundView.swift
//  Dots
//
//  Created by Jack Zhao on 1/20/21.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
        
    }
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        return view
    }
    typealias UIViewType = UIView
}

struct BlurView_Previews: PreviewProvider {
    static var previews: some View {
        BlurView()
    }
}
