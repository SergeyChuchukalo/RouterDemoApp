//
//  PSelectScreenToShowVCModel.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import Foundation

protocol PSelectScreenToShowVCModel {
    /// Variable
    var callback:((SelectScreenToShowVCState) -> Void)? { get set }
    func viewWillAppear()
}
