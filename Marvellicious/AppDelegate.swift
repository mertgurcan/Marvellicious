//
//  AppDelegate.swift
//  Marvellicious
//
//  Created by Mert Gürcan on 20.02.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        prepare()
        return true
    }
    
    func prepare() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        window = UIWindow()
        let nav = UINavigationController(rootViewController: CharacterListBuilder.build())
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
