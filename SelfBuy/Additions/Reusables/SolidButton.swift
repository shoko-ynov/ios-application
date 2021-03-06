//
//  SolidButton.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

class SolidButton: UIButton {

    init(text: String) {
        super.init(frame: .init(x: 0, y: 0, width: 250, height: 50))
        
        setTitle(text, for: .normal)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        setTitleColor(.white, for: .normal)
        titleLabel?.setToBold(size: 16)
        contentHorizontalAlignment = .center
        
        layer.insertSublayer(getGradient(), at: 0)
    }
    
    func getGradient() -> CALayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.lightPrimary.cgColor, UIColor.lightPrimary.cgColor, UIColor.primary.cgColor]
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = frame.height / 2
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        return gradientLayer
    }
    
    override func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        super.anchor(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing,
            padding: padding
        )
    }
    
    override func anchor(top: NSLayoutYAxisAnchor?, bottom: NSLayoutYAxisAnchor?, centerAnchor: NSLayoutXAxisAnchor, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        super.anchor(
            top: top,
            bottom: bottom,
            centerAnchor: centerAnchor,
            padding: padding
        )
    }
}
