//
//  File.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 12/02/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class ProfileInput: UIView {
    
    private let editInput: UITextField = {
        let editInput = UITextField()
            editInput.backgroundColor = UIColor.white
            editInput.textColor = UIColor.black
            editInput.minimumFontSize = 20.0
            editInput.borderStyle = UITextField.BorderStyle.roundedRect
            editInput.layer.cornerRadius = 5.0
            editInput.font = UIFont(name: "Poppins", size: 15.0)
            editInput.becomeFirstResponder()
        
        return editInput
    }()
    
    private let editLabel: UILabel = {
        let editLabel = UILabel()
        editLabel.textColor = UIColor.black
        editLabel.setToMedium(size: 20)
        
        return editLabel
    }()
    
    init(title: String, input: String) {
           super.init(frame: .zero)

        self.addSubview(editInput)
        self.addSubview(editLabel)
        
        editInput.text = input
        editLabel.text = title
   
        editInput.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: nil,
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: 40, bottom: 0, right: 40)
        )
        
        editLabel.anchor(
            top: nil,
            leading: self.leadingAnchor,
            bottom: editInput.topAnchor,
            trailing: self.trailingAnchor,
            padding: .init(top: 0, left: 40, bottom: 0, right: 0)
        )

        func editData(){
            
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
