//
//  UINavigationControllerExtensions.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 19/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    public convenience init(controller: UIViewController, imageName image: String) {
        self.init(rootViewController: controller)
        controller.tabBarItem.image = UIImage(named: image)
    }
    
}
