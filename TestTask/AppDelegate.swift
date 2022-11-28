//
//  AppDelegate.swift
//  TestTask
//
//  Created by Dmitriy Veremei on 15.11.22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        coordinator = AppCoordinator()
        coordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.rootController
        window?.makeKeyAndVisible()
        
        StorageService.shared.start()
        CanvasManager.shared.start()
        
        return true
    }
}

