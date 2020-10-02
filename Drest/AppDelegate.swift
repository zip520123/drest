//
//  AppDelegate.swift
//  Drest
//
//  Created by zip520123 on 01/10/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let service = Service()
    let defaultVC = ViewController(service: service)
    let navigation = UINavigationController(rootViewController: defaultVC)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()
    return true
  }

}

