//
//  SelectScreenToShowVC.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import UIKit
/// Settings View State
enum SelectScreenToShowVCState {
    case updateInellectualParamsScreen(Bool)
    case updatePhysicalParansScreen(Bool)
    case updateAllergensScreenShow(Bool)
    case updatePreferenceScreen(Bool)
    case updateUserDetailShow(Bool)
}
class SelectScreenToShowVC: ViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var inellectualParamsScreenShowSwitch: UISwitch!
    @IBOutlet private weak var physicalParansScreenShowSwitch: UISwitch!
    @IBOutlet private weak var preferenceScreenShowSwitch: UISwitch!
    @IBOutlet private weak var allergensScreenShowSwitch: UISwitch!
    @IBOutlet private weak var userDetailShowSwitch: UISwitch!
    @IBOutlet private weak var nextButon: UIButton!
    // MARK: - Variable
    var viewModel: PSelectScreenToShowVCModel?
    // MARK: - Selectors
    @objc private func inellectualParamsSwitchChange(_ sender: UISwitch) { }
    @objc private func physicalParansSwitchChange(_ sender: UISwitch) { }
    @objc private func preferenceSwitchChange(_ sender: UISwitch) { }
    @objc private func allergensSwitchChange(_ sender: UISwitch) { }
    @objc private func userDetailSwitchChange(_ sender: UISwitch) { }
    @objc private func nextButonTouched() { }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let model = viewModel else { return }
        model.viewWillAppear()
    }
    // MARK: - Helpers
    private func setupTargets() {
        guard var model = viewModel else { return }
        model.callback = { [weak self] state in DispatchQueue.main.async { self?.onStateChange(state) } }
        inellectualParamsScreenShowSwitch.addTarget(model, action: #selector(inellectualParamsSwitchChange(_:)), for: .valueChanged)
        physicalParansScreenShowSwitch.addTarget(model, action: #selector(physicalParansSwitchChange(_:)), for: .valueChanged)
        preferenceScreenShowSwitch.addTarget(model, action: #selector(preferenceSwitchChange(_:)), for: .valueChanged)
        allergensScreenShowSwitch.addTarget(model, action: #selector(allergensSwitchChange(_:)), for: .valueChanged)
        userDetailShowSwitch.addTarget(model, action: #selector(userDetailSwitchChange(_:)), for: .valueChanged)
        nextButon.addTarget(model, action: #selector(nextButonTouched), for: .touchUpInside)
    }
    private func onStateChange(_ state: SelectScreenToShowVCState) {
        switch state {
            
        case .updateInellectualParamsScreen(let state):
            inellectualParamsScreenShowSwitch.setOn(state, animated: false)
        case .updatePhysicalParansScreen(let state):
            physicalParansScreenShowSwitch.setOn(state, animated: false)
        case .updatePreferenceScreen(let state):
            preferenceScreenShowSwitch.setOn(state, animated: false)
        case .updateAllergensScreenShow(let state):
            allergensScreenShowSwitch.setOn(state, animated: false)
        case .updateUserDetailShow(let state):
            userDetailShowSwitch.setOn(state, animated: false)
        }
    }
}
