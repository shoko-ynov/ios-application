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
        
        //        let ultraLightConfiguration = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .light, scale: .large)
        let ultraLightConfiguration = UIImage.SymbolConfiguration(weight: .ultraLight)
        let ultraLightSymbolImage = UIImage(systemName: "chevron.right", withConfiguration: ultraLightConfiguration)
        
        let test = ultraLightSymbolImage!.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        
        
        // PROFILE PICTURE
        //        let profilePictureView = UIImageView()
        //        profilePictureView.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 60, y: 150, width: 120, height: 120)
        //        profilePictureView.image = UIImage(named: avatarFileName)
        //        profilePictureView.layer.cornerRadius = 60
        //        profilePictureView.layer.masksToBounds = true
        //        self.view.addSubview(profilePictureView)
        //
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        _ = setTitleLabel("Profile")
        
        
        // MARK: Profile name label
        let profileNameLabel = UILabel()
        profileNameLabel.textColor = UIColor.black
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
        profileEmailLabel.textColor = UIColor.black
        profileEmailLabel.text = profileEmail
        profileEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        profileEmailLabel.textAlignment = .center
        profileEmailLabel.setToLight(size: 20.0)
        self.view.addSubview(profileEmailLabel)
        
        profileEmailLabel.anchor(
            top: profileNameLabel.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
    
        
        // MARK: Account
        let accountButton = ProfileButton(text: "Account", viewController: AccountViewController.self)
        
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
        let ordersButton = ProfileButton(text: "Orders", viewController: OrdersViewController.self)
        
        self.view.addSubview(ordersButton)
        ordersButton.anchor(
            top: accountButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        ordersButton.onTapHandler = { [weak self] in
                 self?.present(OrdersViewController(), animated: true)
        }
        
         // MARK: Payment method button
        let paymentButton = ProfileButton(text: "Payment", viewController: PaymentViewController.self)
        
        self.view.addSubview(paymentButton)
        paymentButton.anchor(
            top: ordersButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        paymentButton.onTapHandler = { [weak self] in
                 self?.present(PaymentViewController(), animated: true)
        }
        
        // MARK: Privacy & Policy button
        let ppButton = ProfileButton(text: "Privacy & Policy", viewController: PPViewController.self)
          
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
        let aboutUsButton = ProfileButton(text: "About us", viewController: AboutUsViewController.self)
           
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
    
    
    
    @objc private func pushProfileOrdersButtonAction() {
        let orderVC = AboutUsViewController()
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    
    
    @objc private func pushProfilePaymentButtonAction() {
        let paymentVC = AboutUsViewController()
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    
    
    
    @objc private func pushPrivacyPButtonAction() {
        let ppVC = AboutUsViewController()
        self.navigationController?.pushViewController(ppVC, animated: true)
    }
    
    
    
    @objc private func pushAboutUsButtonAction() {
        let aboutUsVC = AboutUsViewController()
        self.navigationController?.pushViewController(aboutUsVC, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc private func pushLogoutButtonAction() {
        // no implementation
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
