//
//  AppDelegate+Extension.swift
//  GetDonate
//
//  Created by JMD on 05/01/21.
//

import Foundation
import UIKit

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    static var rootViewController: UIViewController? {
        return AppDelegate.shared.window?.rootViewController
    }
    //MARK: ==: Navigation Setup :==
    func navigationSetup() {
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), NSAttributedString.Key.font : Font.Medium.of(size: 15)]
        UINavigationBar.appearance().isTranslucent = false
    }
    public func topViewController()-> UIViewController {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        } else {
            return UIViewController()
        }
    }
    //MARK: User Logout
    public func userLogout() {
        NSUserDefaults.deleteAllValues()
        AppDelegate.shared.relaunchRootVC()
    }
    ///- Remarks: Relaunch the application when user try to logout.
    public func relaunchRootVC() {
        MainQueue.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            KeyWindow.rootViewController = storyboard.instantiateInitialViewController()
        }
    }
}
