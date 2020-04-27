//
//  BreadcrumbStep.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

final class BreadcrumbStepView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        
        return imageView
    }()
    
    init(imageName: String) {
        super.init(frame: .zero)
        
        imageView.image = UIImage(named: imageName)
        imageView.image?.withRenderingMode(.alwaysTemplate)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        backgroundColor = .darkGray
        
        layer.cornerRadius = 22.5
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 45),
            widthAnchor.constraint(equalToConstant: 45)
        ])
        
        imageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 10, right: 10)
        )
    }
    
    func disableStep() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.backgroundColor = .darkGray
        }
    }
    
    func enableStep() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.backgroundColor = .primary
        }
    }
}
