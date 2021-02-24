//
//  SwiftUIView.swift
//  Dots
//
//  Created by Jack Zhao on 2/18/21.
//

import SwiftUI

struct NotificationBubble: View {
    let message: String
    let actionPrompt: String
    var action: () -> ()
    
    /// Stores the value of current color scheme.
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        HStack (spacing: 0) {
            Spacer()
            Text(message)
                .font(.caption)
                .foregroundColor(notificationBubbleFontColor())
            Button(action: action) {
                Text(actionPrompt)
                    .font(.caption2)
                    .bold()
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .background(notificationBubbleBackground())
        .clipShape(Capsule(style: .continuous))
    }
    
    private func notificationBubbleBackground() -> Color {
        if scheme == .dark {
            return Color(UIColor(rgb: 0x28282B))
        }
        else {
            return Color(UIColor(rgb: 0xF3F2F5))
        }
    }
    
    private func notificationBubbleFontColor() -> Color {
        if scheme == .dark {
            return Color(UIColor(rgb: 0xE5E5E5))
        }
        else {
            return Color(UIColor(rgb: 0x747474))
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationBubble(message: "You have 1 unpaid bill, ", actionPrompt: "Settle now!", action: {})
            .preferredColorScheme(.dark)
    }
}
