//
//  AppDelegate.swift
//  News2
//
//  Created by MacBook on 4/24/23.
//

import Foundation
import UIKit

//we call loadStores in the start of the app, like the AppDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        CoreDataManager.shared.loadStores()
        return true
    }
}
