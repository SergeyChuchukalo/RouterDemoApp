//
//  GestureContentVC.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import UIKit
/// Class for add Content into GestureContainerVC when content dont table view
class GestureContentVC: ViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGestureDelegate()
    }
    /// Setup gesture
    private func setupGestureDelegate() {
        view.superview?.superview?.gestureRecognizers?.last?.delegate = self
    }
    /// Override dismiss vc
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        parent?.dismiss(animated: flag, completion: completion)
    }
}

/// Prefore gesture between table view guests and hide vc guest
extension GestureContentVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer,
                  panGesture.translation(in: self.view).y < panGesture.translation(in: self.view).x else { return true }
        return false
    }
}
