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
    
    // Button arrow
    let chevron_left = UIImage(systemName: "chevron.left")
    let chevron_right = UIImage(systemName: "chevron.right")
    
    let loginVC = LoginViewController(viewModel: LoginViewModel())
    var titleLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        setHeaderImage()
        titleLabel = setTitleLabel("Profile", textColor: UIColor.white)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        loginVC.onDismiss = {[weak self] in
            if let _ = UserDefaults.standard.string(forKey: "TOKEN") {
                self?.showView()
            } else {
                self?.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = UserDefaults.standard.string(forKey: "TOKEN") {
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
        let accountButton = ProfileButton(text: "Account")
        
        scrollView.addSubview(accountButton)
        
        accountButton.anchor(
            top: scrollView.topAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 300, left: 0, bottom: 0, right: 0)
        )
        
        accountButton.onTapHandler = { [weak self] in
            self?.present(AccountViewController(viewModel: UserViewModel()), animated: true)
        }
        
        // MARK: Orders button
        let ordersButton = ProfileButton(text: "Orders")
        
        scrollView.addSubview(ordersButton)
        
        ordersButton.anchor(
            top: accountButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        
        /*ordersButton.onTapHandler = { [weak self] in
            self?.present(AboutUsViewController(), animated: true)
        }*/
        
        // MARK: Payment method button
        let paymentButton = ProfileButton(text: "Payment")
        
        scrollView.addSubview(paymentButton)
        
        paymentButton.anchor(
            top: ordersButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        paymentButton.onTapHandler = { [weak self] in
            self?.present(PaymentMethodViewController(viewModel: PaymentMethodViewModel()), animated: true)
        }
        
        // MARK: Privacy & Policy button
        let ppButton = ProfileButton(text: "Privacy & Policy")
        
        scrollView.addSubview(ppButton)
        
        ppButton.anchor(
            top: paymentButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        /*ppButton.onTapHandler = { [weak self] in
            self?.present(PPViewController(), animated: true)
        }*/
        
        // MARK: About us button
        let aboutUsButton = ProfileButton(text: "About us")
        
        scrollView.addSubview(aboutUsButton)
        
        aboutUsButton.anchor(
            top: ppButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0)
        )
        /*aboutUsButton.onTapHandler = { [weak self] in
            self?.present(AboutUsViewController(), animated: true)
        }*/
        
        // MARK: Disconnect button
        let disconnectButton = ProfileButton(text: "Se déconnecter")
        
        scrollView.addSubview(disconnectButton)
        
        disconnectButton.anchor(
            top: aboutUsButton.bottomAnchor,
            leading: self.view.leadingAnchor,
            bottom: scrollView.bottomAnchor,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 20, right: 0)
        )
        
        disconnectButton.onTapHandler = { [weak self] in
            UserDefaults.standard.set(nil, forKey: "TOKEN")
            UserDefaults.standard.set(nil, forKey: "refreshToken")
            self?.present(self!.loginVC, animated: true)
        }
        
    }
}
