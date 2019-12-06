//
//  AppDelegate.swift
//  HandMade
//
//  Created by 민쓰 on 03/12/2019.
//  Copyright © 2019 민쓰. All rights reserved.
//

import UIKit
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        
        // 다크테마 방지
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        let rootViewController = MainViewController()
        let rootViewModel = MainViewModel()
        rootViewController.bind(rootViewModel)
        
        let naviController = UINavigationController(rootViewController: rootViewController)
        naviController.do {
            $0.view.backgroundColor = .white
            $0.navigationBar.isTranslucent = true
            if #available(iOS 11.0, *) {
                $0.navigationBar.prefersLargeTitles = true
            }
        }
        
        window?.rootViewController = naviController
        window?.makeKeyAndVisible()
        
        return true
    }

}

