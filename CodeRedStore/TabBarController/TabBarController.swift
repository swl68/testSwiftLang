//
//  TabBarController.swift
//  CodeRedStore
//
//  Created by denisok on 27/03/2020.
//  Copyright © 2020 denisok. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, CoreDataStackDelegate {
    
    let basketViewController = UINavigationController.init(rootViewController: BasketViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataStack.shared.delegate = self
        
        setupTabBar()
    }
    
    func setupTabBar() {
        let startViewController = UINavigationController.init(rootViewController: StartViewController())
        
        startViewController.navigationBar.barStyle = .black
        startViewController.navigationBar.isTranslucent = false
        startViewController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        startViewController.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        startViewController.tabBarItem.image = UIImage(named: "searchUnselected")
        startViewController.tabBarItem.selectedImage = UIImage(named: "searchSelected")?.withRenderingMode(.alwaysTemplate)
        
        basketViewController.navigationBar.barStyle = .black
        basketViewController.navigationBar.isTranslucent = false
        basketViewController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        basketViewController.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        dataDidChanged()
        
        basketViewController.tabBarItem.image = UIImage(named: "basketUnselected")
        basketViewController.tabBarItem.selectedImage = UIImage(named: "basketSelected")?.withRenderingMode(.alwaysTemplate)
        
        viewControllers = [startViewController, basketViewController]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("view will apear in tabbar controller")
    }
    
    func dataDidChanged() {
        
        print("check change badge value")
        let count = CoreDataStack.shared.getCountProduct()
        print(count)
        if Int(count) != 0 {
            basketViewController.tabBarItem.badgeValue = count
        }
    }

}
