//
//  PhysicalParamsVC.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import UIKit

class PhysicalParamsVC: ViewController {
    // MARK: - Variable
    var viewModel: PPhysicalParamsVCModel?
    var compliteCallback:(() -> Void)?
    // MARK: - IBOutlet
    @IBOutlet private weak var nextButton: UIButton!
    // MARK: - Selectors
    @objc private func nextButonTouched() { }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        compliteCallback?()
    }
    // MARK: - Helpers
    private func setupTargets() {
        guard let model = viewModel else { return }
        nextButton.addTarget(model, action: #selector(nextButonTouched), for: .touchUpInside)
    }
}
