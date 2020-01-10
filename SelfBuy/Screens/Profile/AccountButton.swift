
//
//  ProfileButton.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 04/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class AccountButton: UIView {
    
    let ProfileViewController = UINavigationController()
    let bag = DisposeBag()
    var onTapHandler: (() ->Void)?
    
    private let button: UIButton = {
        let button = UIButton()
        button.titleLabel?.setToMedium(size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let profileData: UILabel = {
        let profileData = UILabel()
        profileData.setToLight(size: 16)
        profileData.textColor = UIColor.gray
        profileData.text = "Zakarya TOLBA"
        profileData.translatesAutoresizingMaskIntoConstraints = false
        
        return profileData
    }()
    
    
    init(text: String, iconName: String, data: String, viewController: UIViewController.Type) {
        super.init(frame: .zero)
        
        
        profileData.text = data
        let icon = UIImageView(image: UIImage(systemName: iconName, withConfiguration: UIImage.SymbolConfiguration(scale: .large))?.withTintColor(UIColor.primary, renderingMode: .alwaysOriginal))
        button.setTitle(text, for: .normal)
        
        self.addSubview(button)
        self.addSubview(icon)
        self.addSubview(profileData)
        
        button.titleLabel?.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 100, bottom: 0, right: 0)
        )
        
        icon.anchor(
            top: self.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: button.leadingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 20)
//            size: .init(width: 35, height: 30)
        )
        
        profileData.anchor(
            top: button.bottomAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: -5, left: 100, bottom: 0, right: 150)

        )
        
        button
            .rx
            .tap
            .bind {
                self.onTapHandler?()
            }.disposed(by: bag)
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
