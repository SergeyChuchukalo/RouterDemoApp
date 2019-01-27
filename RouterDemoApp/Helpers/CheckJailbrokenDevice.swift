//
//  CheckJailbrokenDevice.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import Foundation

class CheckJailbrokenDevice {
    /// Singleton initialize
    static let sharedInstance = CheckJailbrokenDevice()
    /// private initializer
    private init() {}
    /// Variable to change
    private var isNeedToReturn: Bool?
    /// Return fake data to UI tests
    func returnFakeResult(result: Bool) {
        isNeedToReturn = result
    }
    /// Get Status what we needed
    func getDeviceStatus() -> Bool {
        if let fakeData = isNeedToReturn { return fakeData }
        return getRealDeviceStatus()
    }
    /// Implement real Jailbroken device status
    private func getRealDeviceStatus() -> Bool {
        return true
    }
}
