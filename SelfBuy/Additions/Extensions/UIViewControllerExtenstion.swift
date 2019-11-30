//
//  UIViewCnntrollerExtenstion.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setTitleLabel(_ title: String) -> UILabel {
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.text = title
            label.setToBold(size: 30)
            
            return label
        }()
        
        self.view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        return titleLabel
    }
    
}
