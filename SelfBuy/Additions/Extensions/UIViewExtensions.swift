//
//  UIViewExtensions.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 19/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
   
    func applyShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.13
    }
    
}
