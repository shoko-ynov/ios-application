//
//  EditButton.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 12/02/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class EditButton: UIView {
    
    let ProfileViewController = UINavigationController()
    let bag = DisposeBag()
    var onTapHandler: (() ->Void)?
    
    private let button: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private let icon : UIImageView = {
        let image = UIImage(systemName: "pencil.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35.0, weight: .regular, scale: .large))?.withTintColor(UIColor.primary, renderingMode: .alwaysOriginal)
        
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    
    
    init() {
        super.init(frame: .zero)
        
        self.addSubview(button)
        self.addSubview(icon)
        
        button.titleLabel?.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        icon.anchor(
            top: self.topAnchor,
            leading: button.trailingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        button
            .rx
            .tap
            .bind {
                print("ça marche")
                self.onTapHandler?()
        }.disposed(by: bag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
