//
//  ViewController.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Init with coder -
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    //––––––––––––––––––––––––––––––––––––––––
    // MARK: - Deinit -
    deinit { debugPrint("🔻Deinit \(type(of: self))") }
    //––––––––––––––––––––––––––––––––––––––––
    // MARK: - Init -
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
        debugPrint("🔻Init \(type(of: self))")
    }
}
