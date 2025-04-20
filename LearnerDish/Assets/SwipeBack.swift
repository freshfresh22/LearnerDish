//
//  SwipeBack.swift
//  LearnerDish
//
//  Created by 이시은 on 4/20/25.
//

import SwiftUI

struct SwipeBack: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(SwipeBackRestorer())
    }
}

extension View {
    func enableSwipeBack() -> some View {
        self.modifier(SwipeBack())
    }
}

private struct SwipeBackRestorer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        
        DispatchQueue.main.async {
            if let nc = controller.navigationController {
                // 🔥 슬라이드 제스처 복구
                nc.interactivePopGestureRecognizer?.isEnabled = true
                nc.interactivePopGestureRecognizer?.delegate = nil
            }
        }
        
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
