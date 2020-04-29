//
//  ModuleBuilder.swift
//  CodeRedStore
//
//  Created by denisok on 10/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

protocol ModuleBuilderProtocol: class {
    static func createRootModule() -> UIViewController
    static func createTabBarModule() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    static func createRootModule() -> UIViewController {
        let startViewController = StartViewController()
        let rootVc = UINavigationController(rootViewController: startViewController)
        rootVc.navigationBar.barStyle = .black
        rootVc.navigationBar.isTranslucent = false
        rootVc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        rootVc.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        return rootVc
    }
    
    static func createTabBarModule() -> UIViewController {
        let tabBarController = TabBarController()
        tabBarController.tabBar.barStyle = .black
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        return tabBarController
    }
    
}
