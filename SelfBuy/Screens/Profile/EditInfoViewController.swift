//
//  EditInfoViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 10/01/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class EditInfoViewController: UIViewController {
   
    
    let bag = DisposeBag()
    
    private let okButton: UIButton = {
            let button = UIButton()
            return button
    }()
    
    private let closeIcon : UIImage = {
        let image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25.0, weight: .regular, scale: .large))?.withTintColor(UIColor.primary, renderingMode: .alwaysOriginal)
        return image!
    }()
        
    override func loadView() {
         super.loadView()
        
        _ = setTitleLabel("Edit")
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true
     
       
         
        // MARK: Edit name
        let editName = UITextField()
            editName.backgroundColor = UIColor.white
            editName.textColor = UIColor.black
            editName.minimumFontSize = 20.0
            editName.borderStyle = UITextField.BorderStyle.roundedRect
            editName.layer.cornerRadius = 5.0
            editName.font = UIFont(name: "Poppins", size: 15.0)
            editName.becomeFirstResponder()
        
        let editNameLabel: UILabel = {
            let editNameLabel = UILabel()
            editNameLabel.textColor = UIColor.black
            editNameLabel.setToMedium(size: 20)
            editNameLabel.text = "Name"
            
            return editNameLabel
        }()
    
        
        self.view.addSubview(editName)
        self.view.addSubview(editNameLabel)
        
        editName.anchor(
            top: self.view.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 120, left: 40, bottom: 0, right: 40)
        )
        
        editNameLabel.anchor(
            top: nil,
            leading: self.view.leadingAnchor,
            bottom: editName.topAnchor,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 0, left: 40, bottom: 0, right: 0)
        )
        
        // MARK: Edit address
        let editAddress = ProfileInput(title: "Address", input: "27 Rue Raoul Servent 69007 Lyon")
        
//        let editAddress = UITextField()
//        editAddress.backgroundColor = UIColor.white
//        editAddress.textColor = UIColor.black
//        editAddress.minimumFontSize = 20.0
//        editAddress.borderStyle = UITextField.BorderStyle.roundedRect
//        editAddress.layer.cornerRadius = 5.0
//        editAddress.font = UIFont(name: "Poppins", size: 15.0)
//        editAddress.becomeFirstResponder()
        
        self.view.addSubview(editAddress)
        
        editAddress.anchor(
            top: editName.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 50, left: 0, bottom: 0, right: 0)
        )
        
//        let editAddressLabel: UILabel = {
//            let editAddressLabel = UILabel()
//            editAddressLabel.textColor = UIColor.black
//            editAddressLabel.setToMedium(size: 20)
//            editAddressLabel.text = "Name"
//
//            return editAddressLabel
//        }()
//
//        editAddress.anchor(
//            top: self.view.topAnchor,
//            leading: self.view.leadingAnchor,
//            bottom: nil,
//            trailing: self.view.trailingAnchor,
//            padding: .init(top: 120, left: 40, bottom: 0, right: 40)
//        )
//
//        editLabel.anchor(
//            top: nil,
//            leading: self.view.leadingAnchor,
//            bottom: editName.topAnchor,
//            trailing: self.view.trailingAnchor,
//            padding: .init(top: 0, left: 40, bottom: 0, right: 0)
//        )
        
        
        // MARK: Edit email
        let editEmail = ProfileInput(title: "Email", input: "test")
            
            self.view.addSubview(editEmail)
            
            editEmail.anchor(
                top: editAddress.bottomAnchor,
                leading: self.view.leadingAnchor,
                bottom: nil,
                trailing: self.view.trailingAnchor,
                padding: .init(top: 80, left: 0, bottom: 0, right: 0)
            )
        
        // MARK: Edit phone
        let editPhone = ProfileInput(title: "Phone", input: "test")
            
            self.view.addSubview(editPhone)
            
            editPhone.anchor(
                top: editEmail.bottomAnchor,
                leading: self.view.leadingAnchor,
                bottom: nil,
                trailing: self.view.trailingAnchor,
                padding: .init(top: 80, left: 0, bottom: 0, right: 0)
            )
        
        // MARK: Edit birth date
        let editBirthdate = ProfileInput(title: "Birth date", input: "06/03/1998")
        
        self.view.addSubview(editBirthdate)
        
        editBirthdate.anchor(
            top: editPhone.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 80, left: 0, bottom: 0, right: 0)
        )
        
      
        
        // MARK: Validation button
        self.view.addSubview(okButton)
        
        okButton.setImage(closeIcon, for: .normal)
        
        okButton.anchor(
            top: self.view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 20)
        )
        
        okButton
            .rx
            .tap
            .bind { [ weak self ] in
//                editData()
                self?.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
        
        
    }
    

}
