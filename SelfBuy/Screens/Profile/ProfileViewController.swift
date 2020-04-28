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
    
    // MARK: Temporary profile menu titles
    let profileName = " "
    let profileEmail = " "
    //    let profileName = "Zakarya Tolba"
    //    let profileEmail = "zakarya.tolba@ynov.com"
    
    
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
        if AuthenticationManager.hasToken() {
            self.showView()
        } else {
            self.present(loginVC, animated: true)
            return;
        }
    }
    
    func showView() {
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

        disconnectButton.onTapHandler = { [weak self] in
            AuthenticationManager.removeTokens()
            self?.present(self!.loginVC, animated: true)
        }
    }
}
