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
    
    private let validationButton: UIButton = {
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
        editName.text = ""
        
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
        let editAddress = UITextField()
        editAddress.backgroundColor = UIColor.white
        editAddress.textColor = UIColor.black
        editAddress.minimumFontSize = 20.0
        editAddress.borderStyle = UITextField.BorderStyle.roundedRect
        editAddress.layer.cornerRadius = 5.0
        editAddress.font = UIFont(name: "Poppins", size: 15.0)
        editAddress.becomeFirstResponder()
        editAddress.text = ""
        
        let editAddressLabel: UILabel = {
            let editAddressLabel = UILabel()
            editAddressLabel.textColor = UIColor.black
            editAddressLabel.setToMedium(size: 20)
            editAddressLabel.text = "Address"
            
            return editAddressLabel
        }()
        
        
        self.view.addSubview(editAddress)
        self.view.addSubview(editAddressLabel)
        
        editAddress.anchor(
            top: editName.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 80, left: 40, bottom: 0, right: 40)
        )
        
        editAddressLabel.anchor(
            top: nil,
            leading: self.view.leadingAnchor,
            bottom: editAddress.topAnchor,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 0, left: 40, bottom: 0, right: 0)
        )
        
        // MARK: Edit email
        let editEmail = UITextField()
          editEmail.backgroundColor = UIColor.white
          editEmail.textColor = UIColor.black
          editEmail.minimumFontSize = 20.0
          editEmail.borderStyle = UITextField.BorderStyle.roundedRect
          editEmail.layer.cornerRadius = 5.0
          editEmail.font = UIFont(name: "Poppins", size: 15.0)
          editEmail.becomeFirstResponder()
          editEmail.text = ""
          
          let editEmailLabel: UILabel = {
              let editEmailLabel = UILabel()
              editEmailLabel.textColor = UIColor.black
              editEmailLabel.setToMedium(size: 20)
              editEmailLabel.text = "Email"
              
              return editEmailLabel
          }()
          
          
          self.view.addSubview(editEmail)
          self.view.addSubview(editEmailLabel)
          
          editEmail.anchor(
              top: editAddress.topAnchor,
              leading: self.view.leadingAnchor,
              bottom: nil,
              trailing: self.view.trailingAnchor,
              padding: .init(top: 80, left: 40, bottom: 0, right: 40)
          )
          
          editEmailLabel.anchor(
              top: nil,
              leading: self.view.leadingAnchor,
              bottom: editEmail.topAnchor,
              trailing: self.view.trailingAnchor,
              padding: .init(top: 0, left: 40, bottom: 0, right: 0)
          )
          
        
        // MARK: Edit phone
        let editPhone = UITextField()
          editPhone.backgroundColor = UIColor.white
          editPhone.textColor = UIColor.black
          editPhone.minimumFontSize = 20.0
          editPhone.borderStyle = UITextField.BorderStyle.roundedRect
          editPhone.layer.cornerRadius = 5.0
          editPhone.font = UIFont(name: "Poppins", size: 15.0)
          editPhone.becomeFirstResponder()
          editPhone.text = ""
          
          let editPhoneLabel: UILabel = {
              let editPhoneLabel = UILabel()
              editPhoneLabel.textColor = UIColor.black
              editPhoneLabel.setToMedium(size: 20)
              editPhoneLabel.text = "Phone"
              
              return editPhoneLabel
          }()
          
          
          self.view.addSubview(editPhone)
          self.view.addSubview(editPhoneLabel)
          
          editPhone.anchor(
              top: editEmail.topAnchor,
              leading: self.view.leadingAnchor,
              bottom: nil,
              trailing: self.view.trailingAnchor,
              padding: .init(top: 80, left: 40, bottom: 0, right: 40)
          )
          
          editPhoneLabel.anchor(
              top: nil,
              leading: self.view.leadingAnchor,
              bottom: editPhone.topAnchor,
              trailing: self.view.trailingAnchor,
              padding: .init(top: 0, left: 40, bottom: 0, right: 0)
          )
        
        // MARK: Edit birth date
        let editBirthdate = UITextField()
          editBirthdate.backgroundColor = UIColor.white
          editBirthdate.textColor = UIColor.black
          editBirthdate.minimumFontSize = 20.0
          editBirthdate.borderStyle = UITextField.BorderStyle.roundedRect
          editBirthdate.layer.cornerRadius = 5.0
          editBirthdate.font = UIFont(name: "Poppins", size: 15.0)
          editBirthdate.becomeFirstResponder()
          editBirthdate.text = ""
          
          let editBirthdateLabel: UILabel = {
              let editBirthdateLabel = UILabel()
              editBirthdateLabel.textColor = UIColor.black
              editBirthdateLabel.setToMedium(size: 20)
              editBirthdateLabel.text = "Birth date"
              
              return editBirthdateLabel
          }()
          
          
          self.view.addSubview(editBirthdate)
          self.view.addSubview(editBirthdateLabel)
          
          editBirthdate.anchor(
              top: editPhone.topAnchor,
              leading: self.view.leadingAnchor,
              bottom: nil,
              trailing: self.view.trailingAnchor,
              padding: .init(top: 80, left: 40, bottom: 0, right: 40)
          )
          
          editBirthdateLabel.anchor(
              top: nil,
              leading: self.view.leadingAnchor,
              bottom: editBirthdate.topAnchor,
              trailing: self.view.trailingAnchor,
              padding: .init(top: 0, left: 40, bottom: 0, right: 0)
          )
        
        
        
        // MARK: Validation button
        self.view.addSubview(validationButton)
        
        validationButton.setImage(closeIcon, for: .normal)
        
        validationButton.anchor(
            top: self.view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 20)
        )
        
        validationButton
            .rx
            .tap
            .bind { [ weak self ] in
                //                editData()
                self?.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
        
        
    }
    
    
}
