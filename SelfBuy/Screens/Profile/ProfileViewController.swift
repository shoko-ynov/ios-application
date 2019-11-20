//
//  ProfileViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 07/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
//    var profileView: ProfileView = {
//        let view = UIView()
//        view.alpha = 0
//        view.setController(controller: self)
//        view.setupLayout()
//    }
    
    var profileView: ProfileView!
    
    // Temp string profileName
    let profileName = "Zakarya Tolba"
    
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
        
//        self.view.addSubview(profileView!)
        
        // PROFILE PICTURE
        
        //Temp profile picture
        
        let profilePictureView = UIImageView()
        profilePictureView.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
        profilePictureView.image = UIImage(named: "avatarZak.png")
//        profilePictureView.imgViewCorners()
        self.view.addSubview(profilePictureView)
        
        
        let arrow_right = UIImage(named: "arrow_right.png")
        
        // ACCOUNT BUTTON
        let accountButton = UIButton()
        accountButton.setTitleColor(.gray, for: .normal)
        accountButton.setTitleColor(.black, for: .highlighted)
        accountButton.addTarget(self, action: #selector(pushAccountButtonAction), for: .touchUpInside)
        accountButton.setTitle("Account", for: .normal)
        accountButton.translatesAutoresizingMaskIntoConstraints = false
        accountButton.semanticContentAttribute = .forceRightToLeft
        self.view.addSubview(accountButton)
        
        accountButton.setImage(arrow_right, for: .normal)
        accountButton.imageView?.translatesAutoresizingMaskIntoConstraints = true
        accountButton.imageView?.centerYAnchor.constraint(equalTo: accountButton.centerYAnchor, constant: 0.0).isActive = true
        accountButton.imageView?.trailingAnchor.constraint(equalTo: accountButton.trailingAnchor, constant: -20).isActive = true

        NSLayoutConstraint.activate([
                 accountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100.0),
                 accountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
                 accountButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 50.0),
                 accountButton.heightAnchor.constraint(equalToConstant: 1000.0),
       ])
        
        
        // ORDERS BUTTON
        let ordersButton = UIButton()
        ordersButton.setTitleColor(.gray, for: .normal)
        ordersButton.setTitleColor(.black, for: .highlighted)
        ordersButton.addTarget(self, action: #selector(pushOrdersButtonAction), for: .touchUpInside)
        ordersButton.setTitle("Orders", for: .normal)
        ordersButton.translatesAutoresizingMaskIntoConstraints = false
        ordersButton.semanticContentAttribute = .forceRightToLeft
        self.view.addSubview(ordersButton)
        
        
        ordersButton.setImage(arrow_right, for: .normal)
        ordersButton.imageView?.translatesAutoresizingMaskIntoConstraints = true
        ordersButton.imageView?.centerYAnchor.constraint(equalTo: ordersButton.centerYAnchor, constant: 0.0).isActive = true
        ordersButton.imageView?.trailingAnchor.constraint(equalTo: ordersButton.trailingAnchor, constant: -20).isActive = true

         NSLayoutConstraint.activate([
                  ordersButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100.0),
                  ordersButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
                  ordersButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 100.0),
                  ordersButton.heightAnchor.constraint(equalToConstant: 1000.0),
        ])
        
        
        // PAYMENT BUTTON
        let paymentButton = UIButton()
        paymentButton.setTitleColor(.gray, for: .normal)
        paymentButton.setTitleColor(.black, for: .highlighted)
        paymentButton.addTarget(self, action: #selector(pushPaymentButtonAction), for: .touchUpInside)
        paymentButton.setTitle("Payment", for: .normal)
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.semanticContentAttribute = .forceRightToLeft
        self.view.addSubview(paymentButton)

        
        paymentButton.setImage(arrow_right, for: .normal)
        paymentButton.imageView?.translatesAutoresizingMaskIntoConstraints = true
        paymentButton.imageView?.centerYAnchor.constraint(equalTo: paymentButton.centerYAnchor, constant: 0.0).isActive = true
        paymentButton.imageView?.trailingAnchor.constraint(equalTo: paymentButton.trailingAnchor, constant: -20).isActive = true

         NSLayoutConstraint.activate([
                  paymentButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -100.0),
                  paymentButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -48.0),
                  paymentButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 150.0),
                  paymentButton.heightAnchor.constraint(equalToConstant: 1000.0),
        ])

        
        // LABEL PROFILE NAME
        let profileNameLabel = UILabel()
        profileNameLabel.textColor = .black
        profileNameLabel.text = profileName
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.textAlignment = .center
        self.view.addSubview(profileNameLabel)
        
        NSLayoutConstraint.activate([
             profileNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
             profileNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
             profileNameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
         ])

     
          
        
    }
    
  
    @objc private func pushAccountButtonAction() {
        // no implementation
    }
    
    @objc private func pushPaymentButtonAction() {
         // no implementation
     }
     
    @objc private func pushOrdersButtonAction() {
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
