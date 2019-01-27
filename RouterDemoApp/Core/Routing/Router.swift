//
//  Router.swift
//  RouterDemoApp
//
//  Created by Sergey Chuchukalo on 1/27/19.
//  Copyright © 2019 Sergey Chuchukalo. All rights reserved.
//

import UIKit

struct RouterNeedToPresent {
    var AllergensScreen:    Bool = false
    var PreferenceScreen:   Bool = false
    var UserDetail:         Bool = false
    var PhysicalParams:     Bool = false
    var IntellectualParams: Bool = false
    var ResultVCModel:      Bool = true
}

class Router {
    /// Need screen to show
    var screenNeedToShow = RouterNeedToPresent()
    /// Singleton initialize
    static let sharedInstance = Router()
    /// private initializer
    private init() {}
    /// Create root screen
    class func createRootWindow() -> UIWindow {
        if CheckJailbrokenDevice.sharedInstance.getDeviceStatus() {
            return Router.showSelectScreenToShowVCAsRoot()
        } else {
            return Router.showDeviceIsJailBrokenVCAsRoot()
        }
    }
    private func showAllergensScreen(_ complite:@escaping () -> Void) {
        getRootViewController { [weak self] (fromViewController)  in
            guard let vc = fromViewController else { return }
            let view = AllergensVC()
            view.compliteCallback = complite
            view.viewModel = AllergensVCModel()
            self?.showViewInContainer(view, fromView: vc)
            self?.screenNeedToShow.AllergensScreen = false
        }
    }
    private func showPreferenceScreen(_ complite:@escaping () -> Void) {
        getRootViewController { [weak self] (fromViewController)  in
            guard let vc = fromViewController else { return }
            let view = PreferenceVC()
            view.compliteCallback = complite
            view.viewModel = PreferenceVCModel()
            self?.showViewInContainer(view, fromView: vc)
            self?.screenNeedToShow.PreferenceScreen = false
        }
    }
    private func showUserDetail(_ complite:@escaping () -> Void) {
        getRootViewController { [weak self] (fromViewController)  in
            guard let vc = fromViewController else { return }
            let view = UserDetailVC()
            view.compliteCallback = complite
            view.viewModel = UserDetailVCModel()
            self?.showViewInContainer(view, fromView: vc)
            self?.screenNeedToShow.UserDetail = false
        }
    }
    private func showPhysicalParams(_ complite:@escaping () -> Void) {
        getRootViewController { [weak self] (fromViewController)  in
            guard let vc = fromViewController else { return }
            let view = PhysicalParamsVC()
            view.compliteCallback = complite
            view.viewModel = PhysicalParamsVCModel()
            self?.showViewInContainer(view, fromView: vc)
            self?.screenNeedToShow.PhysicalParams = false
        }
    }
    private func showIntellectualParams(_ complite:@escaping () -> Void) {
        getRootViewController { [weak self] (fromViewController)  in
            guard let vc = fromViewController else { return }
            let view = IntellectualParamsVC()
            view.compliteCallback = complite
            view.viewModel = IntellectualParamsVCModel()
            self?.showViewInContainer(view, fromView: vc)
            self?.screenNeedToShow.IntellectualParams = false
        }
    }
    private func showResultScreen(_ complite:@escaping () -> Void) {
        getRootViewController { [weak self] (fromViewController)  in
            guard let vc = fromViewController else { return }
            let view = ResultVC()
            view.compliteCallback = complite
            view.viewModel = ResultVCModel()
            vc.present(view, animated: true, completion: nil)
            self?.screenNeedToShow.ResultVCModel = false
        }
    }
    func showViewInContainer(_ view: ViewController, fromView: UIViewController) {
        let gesturedView = GesturedContainerVC(clearSpece: 100, backgroundColor: view.view.backgroundColor)
        gesturedView.contentViewController = view
        gesturedView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        fromView.present(gesturedView, animated: true, completion: nil)
    }
    func checkNextScreen(_ complite:@escaping () -> Void) {
        if screenNeedToShow.AllergensScreen == true { showAllergensScreen(complite); return }
        if screenNeedToShow.PreferenceScreen == true { showPreferenceScreen(complite); return }
        if screenNeedToShow.UserDetail == true { showUserDetail(complite); return }
        if screenNeedToShow.PhysicalParams == true { showPhysicalParams(complite); return }
        if screenNeedToShow.IntellectualParams == true { showIntellectualParams(complite); return }
        if screenNeedToShow.ResultVCModel == true { showResultScreen(complite); return }
    }
    ///
    private class func showDeviceIsJailBrokenVCAsRoot() -> UIWindow {
        return showVCAsRoot(DeviceIsJailBrokenVC())
    }
    
    private class func showSelectScreenToShowVCAsRoot() -> UIWindow {
        let view = SelectScreenToShowVC()
        view.viewModel = SelectScreenToShowVCModel()
        return showVCAsRoot(view)
    }
    private class func showVCAsRoot(_ view: UIViewController) -> UIWindow {
        let window = UIWindow()
        let view = view
        window.rootViewController = view
        window.makeKeyAndVisible()
        return window
    }
    /// Get ViewController from root ViewController
    private func getRootViewController(callback: @escaping((UIViewController?) -> Void)) {
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow
            if let rootVC = window?.rootViewController {
                let fromViewController = Router.sharedInstance.getLastPresentedViewController(rootVC, needSecure: false)
                callback(fromViewController.vc)
            } else {
                callback(nil)
            }
        }
    }
    /// Get ViewController on top from this ViwController
    private func getLastPresentedViewController(_ viewController: UIViewController,
                                                needSecure: Bool) -> (vc: UIViewController, isSecure: Bool) {
        guard let presentedViewController = viewController.presentedViewController else {
            return (viewController, needSecure)
        }
        if presentedViewController is UINavigationController {
            return Router.sharedInstance.getLastPresentedViewController(presentedViewController,
                                                                        needSecure: true)
        } else {
            return Router.sharedInstance.getLastPresentedViewController(presentedViewController,
                                                                        needSecure: needSecure)
        }
    }
}
