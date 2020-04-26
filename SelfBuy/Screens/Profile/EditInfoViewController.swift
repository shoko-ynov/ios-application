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
    let viewModel: UserViewModel
    let fieldName: String
    let fieldValue: Any
    
    private let validationButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let validateIcon : UIImage = {
        let image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25.0, weight: .regular, scale: .large))?.withTintColor(UIColor.primary, renderingMode: .alwaysOriginal)
        return image!
    }()
    
    
    init(viewModel: UserViewModel, fieldName: String, fieldValue: Any) {
        self.viewModel = viewModel
        self.fieldName = fieldName
        self.fieldValue = fieldValue
        
        viewModel.showData()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        super.loadView()

        _ = setTitleLabel("Modifier")
        view.backgroundColor = .lightGray
        
        // MARK: Edit name
        let editField = UITextField()
        editField.backgroundColor = UIColor.white
        editField.textColor = UIColor.black
        editField.minimumFontSize = 20.0
        editField.borderStyle = UITextField.BorderStyle.roundedRect
        editField.layer.cornerRadius = 5.0
        editField.font = UIFont(name: "Poppins", size: 15.0)
        editField.becomeFirstResponder()
        editField.text = ""
        
        let editFieldLabel: UILabel = {
            let editFieldLabel = UILabel()
            editFieldLabel.textColor = UIColor.black
            editFieldLabel.setToMedium(size: 20)
            editFieldLabel.text = fieldName
            
            return editFieldLabel
        }()
        
        
        self.view.addSubview(editField)
        self.view.addSubview(editFieldLabel)
        
        editField.anchor(
            top: self.view.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 120, left: 40, bottom: 0, right: 40)
        )
        
        editFieldLabel.anchor(
            top: nil,
            leading: self.view.leadingAnchor,
            bottom: editField.topAnchor,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 0, left: 40, bottom: 0, right: 0)
        )
        
//         MARK: Edit email
//        let editEmail = UITextField()
//        editEmail.backgroundColor = UIColor.white
//        editEmail.textColor = UIColor.black
//        editEmail.minimumFontSize = 20.0
//        editEmail.borderStyle = UITextField.BorderStyle.roundedRect
//        editEmail.layer.cornerRadius = 5.0
//        editEmail.font = UIFont(name: "Poppins", size: 15.0)
//        editEmail.becomeFirstResponder()
//        editEmail.text = ""
//
//        let editEmailLabel: UILabel = {
//            let editEmailLabel = UILabel()
//            editEmailLabel.textColor = UIColor.black
//            editEmailLabel.setToMedium(size: 20)
//            editEmailLabel.text = "Email"
//
//            return editEmailLabel
//        }()
//
//
//        self.view.addSubview(editEmail)
//        self.view.addSubview(editEmailLabel)
//
//        editEmail.anchor(
//            top: editName.topAnchor,
//            leading: self.view.leadingAnchor,
//            bottom: nil,
//            trailing: self.view.trailingAnchor,
//            padding: .init(top: 80, left: 40, bottom: 0, right: 40)
//        )
//
//        editEmailLabel.anchor(
//            top: nil,
//            leading: self.view.leadingAnchor,
//            bottom: editEmail.topAnchor,
//            trailing: self.view.trailingAnchor,
//            padding: .init(top: 0, left: 40, bottom: 0, right: 0)
//        )
//
//
//        // MARK: Edit address
//        let editAddress = UITextField()
//        editAddress.backgroundColor = UIColor.white
//        editAddress.textColor = UIColor.black
//        editAddress.minimumFontSize = 20.0
//        editAddress.borderStyle = UITextField.BorderStyle.roundedRect
//        editAddress.layer.cornerRadius = 5.0
//        editAddress.font = UIFont(name: "Poppins", size: 15.0)
//        editAddress.becomeFirstResponder()
//        editAddress.text = ""
//
//        let editAddressLabel: UILabel = {
//            let editAddressLabel = UILabel()
//            editAddressLabel.textColor = UIColor.black
//            editAddressLabel.setToMedium(size: 20)
//            editAddressLabel.text = "Address"
//
//            return editAddressLabel
//        }()
//
//
//        self.view.addSubview(editAddress)
//        self.view.addSubview(editAddressLabel)
//
//        editAddress.anchor(
//            top: editEmail.topAnchor,
//            leading: self.view.leadingAnchor,
//            bottom: nil,
//            trailing: self.view.trailingAnchor,
//            padding: .init(top: 80, left: 40, bottom: 0, right: 40)
//        )
//
//        editAddressLabel.anchor(
//            top: nil,
//            leading: self.view.leadingAnchor,
//            bottom: editAddress.topAnchor,
//            trailing: self.view.trailingAnchor,
//            padding: .init(top: 0, left: 40, bottom: 0, right: 0)
//        )
//
        
        // MARK: Validation button
        self.view.addSubview(validationButton)
        
        validationButton.setImage(validateIcon, for: .normal)
        
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
