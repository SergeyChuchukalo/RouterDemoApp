//
//  GesturedContainerVC.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import UIKit

class GesturedContainerVC: ViewController {
    // MARK: - HalfScreenVC
    /// Outlet
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var topView: UIView!
    @IBOutlet private weak var downArrow: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    // MARK: Constants
    /// Static constant
    private let instaledTopViewColor: UIColor = UIColor(white: 0, alpha: 0.25)
    private let durationOfAnimations: Double = 0.25
    private let mainViewCornerRadius: CGFloat = 8
    /// Constant settable in initialize
    private let backgroundColor: UIColor
    private let cleanViewHeight: CGFloat
    // MARK: Variables
    var contentView: UIView?
    var contentViewController: ViewController?
    // MARK: - Initializers
    /// Init with decoder
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    /// Custom Init
    init(clearSpece: CGFloat, backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor ?? .clear
        self.cleanViewHeight = clearSpece
        super.init()
    }
    // MARK: - Live cycle
    /// View well appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupContentView()
        setupContentVC()
        setupMainView()
        setupGesture()
    }
    /// View did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeColorOfTopView()
    }
    // MARK: - Override dismissing
    /// Dismiss view
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.view.endEditing(true)
        if flag {
            UIView.animate(withDuration: durationOfAnimations, animations: {
                self.view.backgroundColor = .clear
                self.mainView.frame.origin.y = self.view.frame.height
            }) { (complite) in
                if complite {
                    super.dismiss(animated: flag, completion: completion)
                }
            }
        } else {
            super.dismiss(animated: flag, completion: completion)
        }
    }
    // MARK: - User Interaction
    /// Hide action
    @objc private func hideAction() {
        dismiss(animated: true)
    }
    /// Move main view
    @objc private func moveMailView(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self.view)
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            if mainView.frame.origin.y > cleanViewHeight + containerView.frame.height/4 {
                downArrow.isHighlighted = true
            } else {
                downArrow.isHighlighted = false
            }
            if translation.y > 0 {
                mainView.frame.origin.y = translation.y/2 + (cleanViewHeight)
            }
        }
        if gestureRecognizer.state == .ended {
            if mainView.frame.origin.y > cleanViewHeight + containerView.frame.height/4 {
                hideAction()
            } else {
                UIView.animate(withDuration: durationOfAnimations) {
                    self.mainView.frame.origin.y = self.cleanViewHeight
                }
            }
        }
    }
    // MARK: - Internal functions
    /// Change color of top view into color in constant with animation
    private func changeColorOfTopView() {
        UIView.animate(withDuration: durationOfAnimations, animations: {
            self.view.backgroundColor = self.instaledTopViewColor
        })
    }
    /// Setup main view of controller
    private func setupMainView() {
        mainView.layer.cornerRadius = mainViewCornerRadius
        mainView.backgroundColor = backgroundColor
        topConstraint.constant = cleanViewHeight
    }
    private func setupContentVC() {
        guard let contentController = contentViewController else { return }
        self.addChild(contentController)
        containerView.addSubview(contentController.view)
        contentController.view.frame = containerView.bounds
        contentController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentController.didMove(toParent: self)
    }
    /// Add content view into container view if content exist
    private func setupContentView() {
        guard let contentView = contentView else { return }
        containerView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
    }
    /// Add guesture
    private func setupGesture() {
        mainView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveMailView)))
        downArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideAction)))
        topView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideAction)))
        topView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(moveMailView)))
        addPanGestureRecognizerToСontentTableView(view: containerView, gesture: UIPanGestureRecognizer(target: self, action: #selector(moveMailView)))
    }
    /// Add guesture to table view what can dislocated in content
    private func addPanGestureRecognizerToСontentTableView(view: UIView, gesture: UIPanGestureRecognizer) {
        for subView in view.subviews {
            if let conteinView = subView as? UITableView {
                conteinView.addGestureRecognizer(gesture)
            } else {
                addPanGestureRecognizerToСontentTableView(view: subView, gesture: gesture)
            }
        }
    }
}
