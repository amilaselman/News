//
//  AppDelegate.swift
//  News2
//
//  Created by MacBook on 4/24/23.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        CoreDataManager.shared.loadStores()
        return true
    }
}
