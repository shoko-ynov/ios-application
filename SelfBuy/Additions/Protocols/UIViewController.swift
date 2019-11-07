//
//  File.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 07/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private func setBatTabItem (unSelectedImage: String, selectedImage: String) {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: unSelectedImage)
        tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        self.tabBarItem = tabBarItem
    }
    
}
