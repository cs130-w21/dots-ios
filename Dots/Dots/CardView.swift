//
//  SingleCard.swift
//  Dots
//
//  Created by Guanqun Ma on 1/10/21.
//

import SwiftUI
import UIKit

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

struct ColoredBlurView: UIViewRepresentable {
    
    let background: UIColor
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<ColoredBlurView>) {
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<ColoredBlurView>) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = self.background
        
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

struct CardView: View {
    @Binding var card: BillObject
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: -25) {
                    ForEach(card.attendees, id: \.self) { d in
                        if (d != self.card.initiator) {
                            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                .frame(maxHeight: 20)
                                .foregroundColor(dotColors[d])
                                
                                .opacity(1)
                        }
                    }
                }
                Spacer()
            }
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(card.title)
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    }
                    Text(self.card.getDate())
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(Color(UIColor.systemGray))
                }
                Spacer()
                Text("$" + String(card.billAmount))
                    .fontWeight(.semibold)
                    .font(.system(.title, design: .rounded))
//                    .fontWeight(.semibold)
                    
                    
            }.padding(.horizontal)
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(maxHeight: 20)
                    .foregroundColor(dotColors[self.card.initiator])
                    .opacity(0.8)
               
            }
        }
        .background(BlurView())
    }
}

struct SingleCard_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .constant(BillObject.sample[0]))
            .previewLayout(.sizeThatFits)
    }
}
