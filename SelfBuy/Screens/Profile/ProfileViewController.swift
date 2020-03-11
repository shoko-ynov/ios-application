//
//  ProfileViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 07/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // Temp strings for profileName & avatarFileName
    let profileName = "Zakarya Tolba"
    let profileEmail = "zakarya.tolba@ynov.com"
    
    // Button arrow
    let chevron_left = UIImage(systemName: "chevron.left")
    let chevron_right = UIImage(systemName: "chevron.right")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

    }
    
    override func loadView() {
        super.loadView()
        setHeaderImage()
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        _ = setTitleLabel("Profile", textColor: UIColor.white)
        
        
        // MARK: Profile name label
        let profileNameLabel = UILabel()
        profileNameLabel.textColor = UIColor.white
        profileNameLabel.text = profileName
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.textAlignment = .center
        profileNameLabel.setToBold(size: 25.0)
        self.view.addSubview(profileNameLabel)
        
        profileNameLabel.anchor(
            top: self.view.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 200, left: 0, bottom: 0, right: 0)
        )
        
        
        // MARK: Profile email label
        let profileEmailLabel = UILabel()
        profileEmailLabel.textColor = UIColor.white
        profileEmailLabel.text = profileEmail
        profileEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        profileEmailLabel.textAlignment = .center
        profileEmailLabel.setToMedium(size: 20.0)
        self.view.addSubview(profileEmailLabel)
        
        profileEmailLabel.anchor(
            top: profileNameLabel.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
    
        // text: String, iconName: String, data: String
        // MARK: Account button
        let accountButton = ProfileButton(text: "Account")
        
        self.view.addSubview(accountButton)
        accountButton.anchor(
            top: profileEmailLabel.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 150, left: 0, bottom: 0, right: 0)
        )
        accountButton.onTapHandler = { [weak self] in
            self?.present(AccountViewController(), animated: true)
        }
        
        
        // MARK: Orders button
        let ordersButton = ProfileButton(text: "Orders")
        
        self.view.addSubview(ordersButton)
        ordersButton.anchor(
            top: accountButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        ordersButton.onTapHandler = { [weak self] in
                 self?.present(AboutUsViewController, animated: true)
        }
        
         // MARK: Payment method button
        let paymentButton = ProfileButton(text: "Payment")
        
        self.view.addSubview(paymentButton)
        paymentButton.anchor(
            top: ordersButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        paymentButton.onTapHandler = { [weak self] in
                 self?.present(EditInfoViewController(), animated: true)
        }
        
        // MARK: Privacy & Policy button
        let ppButton = ProfileButton(text: "Privacy & Policy")
        
          self.view.addSubview(ppButton)
          ppButton.anchor(
              top: paymentButton.bottomAnchor,
              leading: self.view.leadingAnchor,
              bottom: nil,
              trailing: self.view.trailingAnchor,
              padding: .init(top: 20, left: 0, bottom: 0, right: 0)
          )
        ppButton.onTapHandler = { [weak self] in
                 self?.present(PPViewController(), animated: true)
        }
        
        // MARK: About us button
        let aboutUsButton = ProfileButton(text: "About us")
           
           self.view.addSubview(aboutUsButton)
           aboutUsButton.anchor(
               top: ppButton.bottomAnchor,
               leading: self.view.leadingAnchor,
               bottom: nil,
               trailing: self.view.trailingAnchor,
               padding: .init(top: 20, left: 0, bottom: 0, right: 0)
           )
            aboutUsButton.onTapHandler = { [weak self] in
                     self?.present(AboutUsViewController(), animated: true)
            }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
