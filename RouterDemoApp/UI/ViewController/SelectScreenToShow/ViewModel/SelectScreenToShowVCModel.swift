//
//  SelectScreenToShowVCModel.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import UIKit

class SelectScreenToShowVCModel: PSelectScreenToShowVCModel {
    var callback: ((SelectScreenToShowVCState) -> Void)?
    
    func viewWillAppear() {
        callback?(.updateInellectualParamsScreen(Router.sharedInstance.screenNeedToShow.IntellectualParams))
        callback?(.updatePhysicalParansScreen(Router.sharedInstance.screenNeedToShow.PhysicalParams))
        callback?(.updateAllergensScreenShow(Router.sharedInstance.screenNeedToShow.AllergensScreen))
        callback?(.updatePreferenceScreen(Router.sharedInstance.screenNeedToShow.PreferenceScreen))
        callback?(.updateUserDetailShow(Router.sharedInstance.screenNeedToShow.UserDetail))
    }
    
    // MARK: - Selectors
    @objc private func inellectualParamsSwitchChange(_ sender: UISwitch) {
        Router.sharedInstance.screenNeedToShow.IntellectualParams = sender.isOn
    }
    @objc private func physicalParansSwitchChange(_ sender: UISwitch) {
        Router.sharedInstance.screenNeedToShow.PhysicalParams = sender.isOn
    }
    @objc private func preferenceSwitchChange(_ sender: UISwitch) {
        Router.sharedInstance.screenNeedToShow.PreferenceScreen = sender.isOn
    }
    @objc private func allergensSwitchChange(_ sender: UISwitch) {
        Router.sharedInstance.screenNeedToShow.AllergensScreen = sender.isOn
    }
    @objc private func userDetailSwitchChange(_ sender: UISwitch) {
        Router.sharedInstance.screenNeedToShow.UserDetail = sender.isOn
    }
    @objc private func nextButonTouched() { Router.sharedInstance.checkNextScreen({[weak self] in self?.viewWillAppear()}) }
}
