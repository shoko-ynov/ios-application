//
//  AccountViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

class AccountViewController: UIViewController {
    
    let bag = DisposeBag()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let editButton: UIButton = {
         let button = UIButton()
         return button
     }()
     
    private let closeIcon : UIImage = {
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25.0, weight: .regular, scale: .large))?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        return image!
    }()
    
    private let editIcon : UIImage = {
         let image = UIImage(systemName: "pencil.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35.0, weight: .regular, scale: .large))?.withTintColor(UIColor.primary, renderingMode: .alwaysOriginal)
         return image!
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
    }
    override func loadView() {
        super.loadView()
        
        _ = setTitleLabel("Account", textColor: UIColor.black)
        navigationController?.navigationBar.isHidden = true
        
        
        // MARK: Close button
        self.view.addSubview(closeButton)
        
        closeButton.setImage(closeIcon, for: .normal)
        
        closeButton.anchor(
            top: self.view.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 25, left: 0, bottom: 0, right: 20)
        )
        
        closeButton
            .rx
            .tap
            .bind { [ weak self ] in
                self?.dismiss(animated: true, completion: nil)
        }.disposed(by: bag)
        
        
        // MARK: Payment method button
        //        let paymentButton = ProfileButton(text: "Payment", viewController: PaymentViewController.self)
        //
        //        self.view.addSubview(paymentButton)
        //        paymentButton.anchor(
        //            top: closeButton.bottomAnchor,
        //            leading: self.view.leadingAnchor,
        //            bottom: nil,
        //            trailing: self.view.trailingAnchor,
        //            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        //        )
        //        paymentButton.onTapHandler = { [weak self] in
        //                 self?.present(EditInfoViewController(), animated: true)
        //        }
        
      
        
        // MARK: Account - Profile Name
        let editProfileName = InfoLine(text: "Name", iconName: "person.fill", data: "Zakarya TOLBA")
        
        self.view.addSubview(editProfileName)
        editProfileName.anchor(
            top: self.view.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 200, left: 0, bottom: 0, right: 0)
        )
        
        // MARK: Account - Address
        let editAddress = InfoLine(text: "Address", iconName: "house.fill", data: "27 Rue Raoul Servant")
        
        self.view.addSubview(editAddress)
        editAddress.anchor(
            top: editProfileName.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 80, left: 0, bottom: 0, right: 0)
        )
        
        // MARK: Account - Email
        let editEmail = InfoLine(text: "Email", iconName: "envelope.fill", data: "zakarya.tolba@ynov.com")
        
        self.view.addSubview(editEmail)
        editEmail.anchor(
            top: editAddress.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 80, left: 0, bottom: 0, right: 0)
        )
        
        // MARK: Account - Phone
        let editPhone = InfoLine(text: "Phone", iconName: "phone.fill", data: "+(33) 6 31 99 18 72")
        
        self.view.addSubview(editPhone)
        editPhone.anchor(
            top: editEmail.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 80, left: 0, bottom: 0, right: 0)
        )
        
        // MARK: Account - Birth Date
        let editBirthDate = InfoLine(text: "Birth date", iconName: "gift.fill", data: "06/03/1998")
        
        self.view.addSubview(editBirthDate)
        editBirthDate.anchor(
            top: editPhone.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 80, left: 0, bottom: 0, right: 0)
        )
        
        func updateData(input: String){
                  editProfileName.text = input
       }
        
        // MARK: Edit button
        self.view.addSubview(editButton)
        
        editButton.setImage(editIcon, for: .normal)
        
        editButton.anchor(
            top: nil,
            leading: self.view.trailingAnchor,
            bottom: self.view.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: -230, bottom: 150, right: 0)
        )
        
        editButton
            .rx
            .tap
            .bind { [ weak self ] in
                self?.present(EditInfoViewController(), animated: true)
        }.disposed(by: bag)
        
    }
}
