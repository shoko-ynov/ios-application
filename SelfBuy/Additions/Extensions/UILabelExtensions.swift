//
//  UILabelExtensions.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func setToBold(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Bold", size: size)
    }
    
    func setToMedium(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Medium", size: size)
    }
    
    func setToLight(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Light", size: size)
    }
    
}

extension UITextField {
    
    func setToBold(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Bold", size: size)
    }
    
    func setToMedium(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Medium", size: size)
    }
    
    func setToLight(size: CGFloat) {
        self.font = UIFont(name: "Poppins-Light", size: size)
    }
    
}
