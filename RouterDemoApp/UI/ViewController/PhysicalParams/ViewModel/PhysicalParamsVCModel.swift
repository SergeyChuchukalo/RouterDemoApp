//
//  PhysicalParamsVCModel.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import Foundation

class PhysicalParamsVCModel: PPhysicalParamsVCModel {
    @objc private func nextButonTouched() { Router.sharedInstance.checkNextScreen({}) }
}
