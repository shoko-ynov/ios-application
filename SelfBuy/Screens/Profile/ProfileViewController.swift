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
//    let avatarFileName = "avatarZak.png"
    let profileName = "Zakarya Tolba"
    // Button arrow
    let arrow_right = UIImage(named: "arrow_right.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        self.title = "Profile"
     
    }
    
    override func loadView() {
        super.loadView()
        
        if #available(iOS 11.0, *) {
             self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            
         }
        
        // PROFILE PICTURE
//        let profilePictureView = UIImageView()
//        profilePictureView.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 60, y: 150, width: 120, height: 120)
//        profilePictureView.image = UIImage(named: avatarFileName)
//        profilePictureView.layer.cornerRadius = 60
//        profilePictureView.layer.masksToBounds = true
//        self.view.addSubview(profilePictureView)
//
   
        // PROFILE NAME LABEL
        let profileNameLabel = UILabel()
        profileNameLabel.textColor = .black
        profileNameLabel.text = profileName
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.textAlignment = .center
        profileNameLabel.font = UIFont(name:"Helvetica", size: 20.0)
        self.view.addSubview(profileNameLabel)
    
              
        NSLayoutConstraint.activate([
               profileNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
               profileNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
               profileNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        // PROFILE EMAIL LABEL
        
        
        // ACCOUNT BUTTON
        let accountProfileButton = UIButton()
        accountProfileButton.setTitleColor(UIColor.gray, for: .normal)
        accountProfileButton.setTitleColor(.black, for: .highlighted)
        accountProfileButton.addTarget(self, action: #selector(pushProfileAccountButtonAction), for: .touchUpInside)
        accountProfileButton.setTitle("Account", for: .normal)
        accountProfileButton.translatesAutoresizingMaskIntoConstraints = false
        accountProfileButton.semanticContentAttribute = .forceRightToLeft
        self.view.addSubview(accountProfileButton)
        
        accountProfileButton.setImage(arrow_right, for: .normal)
        accountProfileButton.imageView?.translatesAutoresizingMaskIntoConstraints = true
        accountProfileButton.imageView?.centerYAnchor.constraint(equalTo: accountProfileButton.centerYAnchor, constant: 80.0).isActive = true
        accountProfileButton.imageView?.trailingAnchor.constraint(equalTo: accountProfileButton.trailingAnchor, constant: -20).isActive = true

        NSLayoutConstraint.activate([
                 accountProfileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100.0),
                 accountProfileButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
                 accountProfileButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -310.0),
                 accountProfileButton.heightAnchor.constraint(equalToConstant: 48.0),
       ])
        
        let lineView1 = UIView(frame: CGRect(x: 35, y: 430, width: 300, height: 1.0))
        lineView1.layer.borderWidth = 1.0
        lineView1.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(lineView1)
        
        // ORDERS BUTTON
        let ordersProfileButton = UIButton()
        ordersProfileButton.setTitleColor(UIColor.gray, for: .normal)
        ordersProfileButton.setTitleColor(.black, for: .highlighted)
        ordersProfileButton.addTarget(self, action: #selector(pushProfileOrdersButtonAction), for: .touchUpInside)
        ordersProfileButton.setTitle("Orders", for: .normal)
        ordersProfileButton.translatesAutoresizingMaskIntoConstraints = false
        ordersProfileButton.semanticContentAttribute = .forceRightToLeft
        self.view.addSubview(ordersProfileButton)


        ordersProfileButton.setImage(arrow_right, for: .normal)
        ordersProfileButton.imageView?.translatesAutoresizingMaskIntoConstraints = true
        ordersProfileButton.imageView?.centerYAnchor.constraint(equalTo: ordersProfileButton.centerYAnchor, constant: 70.0).isActive = true
        ordersProfileButton.imageView?.trailingAnchor.constraint(equalTo: ordersProfileButton.trailingAnchor, constant: -20).isActive = true


        NSLayoutConstraint.activate([
          ordersProfileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100.0),
          ordersProfileButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
          ordersProfileButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -245.0),
          ordersProfileButton.heightAnchor.constraint(equalToConstant: 48.0),
        ])
        
        let lineView2 = UIView(frame: CGRect(x: 35, y: 490, width: 300, height: 1.0))
        lineView2.layer.borderWidth = 1.0
        lineView2.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(lineView2)
        
        // PAYMENT BUTTON
        let paymentProfileButton = UIButton()
        paymentProfileButton.setTitleColor(UIColor.gray, for: .normal)
        paymentProfileButton.setTitleColor(.black, for: .highlighted)
        paymentProfileButton.addTarget(self, action: #selector(pushProfilePaymentButtonAction), for: .touchUpInside)
        paymentProfileButton.setTitle("Payment", for: .normal)
        paymentProfileButton.translatesAutoresizingMaskIntoConstraints = false
        paymentProfileButton.semanticContentAttribute = .forceRightToLeft
        self.view.addSubview(paymentProfileButton)


        paymentProfileButton.setImage(arrow_right, for: .normal)
        paymentProfileButton.imageView?.translatesAutoresizingMaskIntoConstraints = true
        paymentProfileButton.imageView?.centerYAnchor.constraint(equalTo: paymentProfileButton.centerYAnchor, constant: 0.0).isActive = true
        paymentProfileButton.imageView?.trailingAnchor.constraint(equalTo: paymentProfileButton.trailingAnchor, constant: -20).isActive = true

         NSLayoutConstraint.activate([
                  paymentProfileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100.0),
                  paymentProfileButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
                  paymentProfileButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -185.0),
                  paymentProfileButton.heightAnchor.constraint(equalToConstant: 48.0),
        ])

        let lineView3 = UIView(frame: CGRect(x: 35, y: 550, width: 300, height: 1.0))
        lineView3.layer.borderWidth = 1.0
        lineView3.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(lineView3)
        
        // PRIVACY AND POLICY BUTTON
        let ppProfileButton = UIButton()
        ppProfileButton.setTitleColor(UIColor.gray, for: .normal)
        ppProfileButton.setTitleColor(.black, for: .highlighted)
        ppProfileButton.addTarget(self, action: #selector(pushPrivacyPButtonAction), for: .touchUpInside)
        ppProfileButton.setTitle("Privacy & Policy", for: .normal)
        ppProfileButton.translatesAutoresizingMaskIntoConstraints = false
        ppProfileButton.semanticContentAttribute = .forceRightToLeft
        self.view.addSubview(ppProfileButton)


        ppProfileButton.setImage(arrow_right, for: .normal)
        ppProfileButton.imageView?.translatesAutoresizingMaskIntoConstraints = true
        ppProfileButton.imageView?.centerYAnchor.constraint(equalTo: ppProfileButton.centerYAnchor, constant: 0.0).isActive = true
        ppProfileButton.imageView?.trailingAnchor.constraint(equalTo: ppProfileButton.trailingAnchor, constant: -20).isActive = true

        NSLayoutConstraint.activate([
                   ppProfileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100.0),
                   ppProfileButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
                   ppProfileButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -125.0),
                   ppProfileButton.heightAnchor.constraint(equalToConstant: 48.0),
        ])
        
        let lineView4 = UIView(frame: CGRect(x: 35, y: 610, width: 300, height: 1.0))
        lineView4.layer.borderWidth = 1.0
        lineView4.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(lineView4)
        
        
        // ABOUT US BUTTON
        
        let aboutUsProfileButton = UIButton()
        aboutUsProfileButton.setTitleColor(UIColor.gray, for: .normal)
        aboutUsProfileButton.setTitleColor(.black, for: .highlighted)
        aboutUsProfileButton.addTarget(self, action: #selector(pushPrivacyPButtonAction), for: .touchUpInside)
        aboutUsProfileButton.setTitle("About Us", for: .normal)
        aboutUsProfileButton.translatesAutoresizingMaskIntoConstraints = false
        aboutUsProfileButton.semanticContentAttribute = .forceRightToLeft
        self.view.addSubview(aboutUsProfileButton)

        aboutUsProfileButton.setImage(arrow_right, for: .normal)
        aboutUsProfileButton.imageView?.translatesAutoresizingMaskIntoConstraints = true
        aboutUsProfileButton.imageView?.centerYAnchor.constraint(equalTo: aboutUsProfileButton.centerYAnchor, constant: 0.0).isActive = true
        aboutUsProfileButton.imageView?.trailingAnchor.constraint(equalTo: aboutUsProfileButton.trailingAnchor, constant: -20).isActive = true

        NSLayoutConstraint.activate([
                  aboutUsProfileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100.0),
                  aboutUsProfileButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
                  aboutUsProfileButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -65.0),
                  aboutUsProfileButton.heightAnchor.constraint(equalToConstant: 48.0),
        ])
        
        
        // SIGN OUT BUTTON

        
        
    }
    
  
    @objc private func pushProfileAccountButtonAction() {
        // no implementation
    }

     
    @objc private func pushProfileOrdersButtonAction() {
         // no implementation
     }
     

    @objc private func pushProfilePaymentButtonAction() {
         // no implementation
     }
    
    
    @objc private func pushPrivacyPButtonAction() {
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
