//
//  AccountViewController.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func loadView() {
         super.loadView()
    
        _ = setTitleLabel("Account")
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isHidden = true


        // MARK: Account - Profile Name
        let editProfileName = AccountButton(text: "Name", iconName: "person.fill", data: "Zakarya TOLBA", viewController: AccountViewController.self)
        
        self.view.addSubview(editProfileName)
        editProfileName.anchor(
            top: self.view.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 200, left: 0, bottom: 0, right: 0)
        )
        editProfileName.onTapHandler = { [weak self] in
            self?.present(AccountViewController(), animated: true)
        }
        
        
        // MARK: Account - Address
           let editAddress = AccountButton(text: "Address", iconName: "house.fill", data: "27 Rue Raoul Servant", viewController: AccountViewController.self)
           
           self.view.addSubview(editAddress)
           editAddress.anchor(
               top: editProfileName.bottomAnchor,
               leading: self.view.leadingAnchor,
               bottom: nil,
               trailing: self.view.trailingAnchor,
               padding: .init(top: 80, left: 0, bottom: 0, right: 0)
           )
           editAddress.onTapHandler = { [weak self] in
               self?.present(AccountViewController(), animated: true)
           }

        // MARK: Account - Email
           let editEmail = AccountButton(text: "Email", iconName: "envelope.fill", data: "zakarya.tolba@ynov.com", viewController: AccountViewController.self)
           
           self.view.addSubview(editEmail)
           editEmail.anchor(
               top: editAddress.topAnchor,
               leading: self.view.leadingAnchor,
               bottom: nil,
               trailing: self.view.trailingAnchor,
               padding: .init(top: 80, left: 0, bottom: 0, right: 0)
           )
           editEmail.onTapHandler = { [weak self] in
               self?.present(AccountViewController(), animated: true)
           }

        // MARK: Account - Phone
           let editPhone = AccountButton(text: "Phone", iconName: "phone.fill", data: "+(33) 6 31 99 18 72", viewController: AccountViewController.self)
           
           self.view.addSubview(editPhone)
           editPhone.anchor(
               top: editEmail.topAnchor,
               leading: self.view.leadingAnchor,
               bottom: nil,
               trailing: self.view.trailingAnchor,
               padding: .init(top: 80, left: 0, bottom: 0, right: 0)
           )
           editPhone.onTapHandler = { [weak self] in
               self?.present(AccountViewController(), animated: true)
           }

        // MARK: Account - Birth Date
           let editBirthDate = AccountButton(text: "Birth date", iconName: "gift.fill", data: "06/03/1998", viewController: AccountViewController.self)
           
           self.view.addSubview(editBirthDate)
           editBirthDate.anchor(
            top: editPhone.topAnchor,
               leading: self.view.leadingAnchor,
               bottom: nil,
               trailing: self.view.trailingAnchor,
               padding: .init(top: 80, left: 0, bottom: 0, right: 0)
           )
           editBirthDate.onTapHandler = { [weak self] in
               self?.present(AccountViewController(), animated: true)
           }
        
        let profileLine = InfoLine(text: "Account")

        self.view.addSubview(profileLine)
            profileLine.anchor(
                top: nil,
                leading: self.view.leadingAnchor,
                bottom: nil,
                trailing: self.view.trailingAnchor,
                padding: .init(top: 100, left: 0, bottom: 0, right: 0)
            )
            

    }
    
    
}
