//
//  StyledTextField.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 03/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

class StyledTextField: UITextField {

    init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        super.init(frame: .init(x: 0, y: 0, width: 250, height: 50))
        
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        
        if keyboardType == .emailAddress {
            autocapitalizationType = .none
        }
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
        borderStyle = UITextField.BorderStyle.roundedRect
        tintColor = .black
        textColor = .black
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
