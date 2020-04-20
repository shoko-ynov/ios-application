//
//  TabBarService.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

class TabBarService {
    let tabBarController: TabBarViewController
    
    static let shared = TabBarService(tabBarController: TabBarViewController())
    
    init(tabBarController: TabBarViewController) {
        self.tabBarController = tabBarController
    }
}
