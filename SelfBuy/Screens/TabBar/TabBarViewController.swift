//
//  TabBarViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 07/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {

    private var shapeLayer: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let homeNavigationVC = UINavigationController(rootViewController: homeVC)
        homeNavigationVC.tabBarItem.image = UIImage(named: "home")
        
        let profileVC = ProfileViewController()
        let profileNavigationVC = UINavigationController(rootViewController: profileVC)
        profileNavigationVC.tabBarItem.image = UIImage(named: "user")
        
        let searchVC = SearchViewController()
        let searchNavigationVC = UINavigationController(rootViewController: searchVC)
        searchNavigationVC.tabBarItem.image = UIImage(named: "search")
        
        self.viewControllers = [ homeNavigationVC, profileNavigationVC, searchNavigationVC ]
        
        //tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        tabBar.tintColor = .green
        
        for tabBarItem in tabBar.items! {
            tabBarItem.title = ""
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
}
