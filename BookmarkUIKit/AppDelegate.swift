//
//  AppDelegate.swift
//  BookmarkUIKit
//
//  Created by Алдияр Айтпаев on 18.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        if Storage.showOnboarding {
            self.window?.rootViewController = UINavigationController(rootViewController: ViewController())
            
        } else {
            self.window?.rootViewController = UINavigationController(rootViewController: SecondScreen())
                                                                     
        }
                                                                   
        
        return true
    }


}

