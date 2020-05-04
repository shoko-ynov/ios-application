//
//  ProfileViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 07/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {
    
    let loginVC = LoginViewController(viewModel: LoginViewModel())
    var titleLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        setHeaderImage()
        titleLabel = setTitleLabel("Profile", textColor: UIColor.white)
        
        loginVC.onDismiss = {[weak self] in
            if AuthenticationManager.hasToken() {
                self?.showView()
            } else {
                self?.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserRepository.shared.getUser() != nil {
            self.showView()
        } else {
            self.present(loginVC, animated: true)
        }
    }
    
    func showView() {
        let profileName = "\(UserRepository.shared.getUser()?.firstName ?? "") \(UserRepository.shared.getUser()?.lastName?.uppercased() ?? "")"
        let profileEmail = "\(UserRepository.shared.getUser()?.mail ?? "")"
        
        // MARK: Profile name label
        let profileNameLabel = UILabel()
        profileNameLabel.textColor = .black
        profileNameLabel.text = profileName
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileNameLabel.textAlignment = .center
        profileNameLabel.setToBold(size: 25.0)
        self.view.addSubview(profileNameLabel)
        
        profileNameLabel.anchor(
            top: self.view.topAnchor,
            bottom: nil,
            centerAnchor: view.centerXAnchor,
            padding: .init(top: 320, left: 0, bottom: 0, right: 0)
        )
        
        // MARK: Profile email label
        let profileEmailLabel = UILabel()
        profileEmailLabel.textColor = .black
        profileEmailLabel.text = profileEmail
        profileEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        profileEmailLabel.textAlignment = .center
        profileEmailLabel.setToMedium(size: 20.0)
        self.view.addSubview(profileEmailLabel)
        
        profileEmailLabel.anchor(
            top: profileNameLabel.bottomAnchor,
            bottom: nil,
            centerAnchor: view.centerXAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0)
        )
        
        // MARK: Scroll view
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.anchor(
            top: titleLabel.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: tabBarController?.tabBar.topAnchor,
            trailing: view.trailingAnchor
        )
        
        // MARK: Account button
        let accountButton = ProfileButton(text: "Compte")
        
        scrollView.addSubview(accountButton)
        
        accountButton.anchor(
            top: scrollView.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 350, left: 0, bottom: 0, right: 0)
        )
        
        accountButton.onTapHandler = { [weak self] in
            self?.present(AccountViewController(viewModel: AccountViewModel()), animated: true)
        }
        
        // MARK: Orders button
        let ordersButton = ProfileButton(text: "Commandes")

        scrollView.addSubview(ordersButton)

        ordersButton.anchor(
            top: accountButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 40, left: 0, bottom: 0, right: 0)
        )

        /*ordersButton.onTapHandler = { [weak self] in
            self?.present(AboutUsViewController(), animated: true)
        }*/

        // MARK: Payment method button
        let paymentButton = ProfileButton(text: "Moyen de paiement")
      
        scrollView.addSubview(paymentButton)

        paymentButton.anchor(
            top: ordersButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 40, left: 0, bottom: 0, right: 0)
        )
        paymentButton.onTapHandler = { [weak self] in
            self?.present(PaymentMethodViewController(viewModel: PaymentMethodViewModel()), animated: true)
        }


        // MARK: Disconnect button
        let disconnectButton = ProfileButton(text: "Se déconnecter")

        scrollView.addSubview(disconnectButton)

        disconnectButton.anchor(
            top: paymentButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: scrollView.bottomAnchor,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 40, left: 0, bottom: 20, right: 0)
        )

        disconnectButton.onTapHandler = {
            showDisconnectAlert()
        }
        
        func showDisconnectAlert() {
            let alert = UIAlertController(title: "Deconnexion", message: "Voulez-vous vraiment vous déconnecter?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { [weak self] action in
                guard let strongSelf = self else { return }
                AuthenticationManager.removeTokens()
                UserRepository.shared.disconnect()
                strongSelf.present(strongSelf.loginVC, animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Non", style: .cancel))
            
            self.present(alert, animated: true)
        }
    }
}
