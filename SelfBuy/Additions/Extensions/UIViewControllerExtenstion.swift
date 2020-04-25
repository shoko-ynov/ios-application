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
    
    func setTitleLabel(_ title: String, textColor color: UIColor = .black) -> UILabel {
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = color
            label.text = title
            label.setToBold(size: 30)
            label.numberOfLines = 2
            
            return label
        }()
        
        self.view.addSubview(titleLabel)
        
        titleLabel.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: .init(top: 20, left: 20, bottom: 0, right: 60)
        )
        
        return titleLabel
    }
    
    func setHeaderImage() {
        
        let headerImage: UIImageView = {
            let image = UIImage(named: "chocolat")
            let imageView = UIImageView()
            imageView.image = image
            
            return imageView
        }()
        
        self.view.addSubview(headerImage)
        
        headerImage.anchor(
            top: self.view.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor
        )
        
        headerImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
}
