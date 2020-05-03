//
//  GhostButton.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 03/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

class GhostButton: SolidButton {
    override func getGradient() -> CALayer {
        let gradient = super.getGradient()
        
        let rect = CGRect(x: 0.5, y: 0, width: gradient.frame.width - 1, height: gradient.frame.height)
        let shape = CAShapeLayer()
        shape.lineWidth = 5
        shape.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        gradient.mask = shape
        
        return gradient
    }
    
    override func setupView() {
        super.setupView()
        
        setTitleColor(.primary, for: .normal)
    }

}
