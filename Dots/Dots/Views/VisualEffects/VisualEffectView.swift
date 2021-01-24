//
//  VisualEffectView.swift
//  Dots
//
//  Created by Jack Zhao on 1/22/21.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var uiVisualEffect: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = uiVisualEffect
    }
}


struct VisualEffectView_Previews: PreviewProvider {
    static var previews: some View {
        VisualEffectView()
    }
}
