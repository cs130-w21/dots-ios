//
//  KeyboardDismiss.swift
//  Dots
//
//  Created by Jack Zhao on 1/26/21.
//
import SwiftUI
import Foundation
import PushKit
import UIKit
public extension View {
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}

public struct DismissKeyboardOnTap: ViewModifier {
    public func body(content: Content) -> some View {
        #if os(macOS)
        return content
        #else
        return content.gesture(tapGesture)
        #endif
    }

    private var tapGesture: some Gesture {
        TapGesture().onEnded(endEditing)
    }

    private func endEditing() {
        UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .map {$0 as? UIWindowScene}
            .compactMap({$0})
            .first?.windows
            .filter {$0.isKeyWindow}
            .first?.endEditing(true)
    }
}
import Foundation
import UIKit
import CoreGraphics
import Combine

class KeyboardProperties: ObservableObject {
  
  static let shared = KeyboardProperties()
  
  @Published var frame = CGRect.zero

  var subscription: Cancellable?

  init() {
    subscription = NotificationCenter.default
      .publisher(for: UIResponder.keyboardDidShowNotification)
      .compactMap { $0.userInfo }
      .compactMap {
        $0[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
      }
      .merge(
        with: NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification).map { _ in
          CGRect.zero
        }
      )
      .assign(to: \.frame, on: self)
  }
}

//
//extension Publishers {
//    // 1.
//    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
//        // 2.
//        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .map { $0.keyboardHeight }
//        
//        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .map { _ in CGFloat(0) }
//        
//        // 3.
//        return MergeMany(willShow, willHide)
//            .eraseToAnyPublisher()
//    }
//}
//
//extension Notification {
//    var keyboardHeight: CGFloat {
//        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
//    }
//}
