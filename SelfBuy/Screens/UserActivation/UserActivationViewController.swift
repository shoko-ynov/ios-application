//
//  UserActivationViewController.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit

class UserActivationViewController: PresentableViewController {
    
    let viewModel: UserActivationViewModelling
    
    private var passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = " Mot de passe"
        password.backgroundColor = .white
        password.isSecureTextEntry = true
        password.layer.cornerRadius = 15
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.tintColor = .black
        password.textColor = .black
        
        return password
    }()
    
    private var passwordConfirmationTextField: UITextField = {
        let password = UITextField()
        password.placeholder = " Confirmer votre mot de passe"
        password.backgroundColor = .white
        password.isSecureTextEntry = true
        password.layer.cornerRadius = 15
        password.borderStyle = UITextField.BorderStyle.roundedRect
        password.tintColor = .black
        password.textColor = .black
        
        return password
    }()
    
    private var activationButton: UIButton = {
        let button:UIButton = UIButton()
        button.backgroundColor = .primary
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        button.setTitle("Activer mon compte", for: .normal)
        
        return button
    }()
    
    init(viewModel: UserActivationViewModelling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        let _ = setTitleLabel("Activer mon compte")
        
        view.addSubview(passwordTextField)
        view.addSubview(passwordConfirmationTextField)
        view.addSubview(activationButton)
        
        activationButton.anchor(
            top: nil,
            leading: nil,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: 150, right: 0),
            size: .init(width: 250, height: 50)
        )
        activationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        passwordConfirmationTextField.anchor(
            top: nil,
            leading: nil,
            bottom: activationButton.topAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: 60, right: 0),
            size: .init(width: 250, height: 50)
        )
        passwordConfirmationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        passwordTextField.anchor(
            top: nil,
            leading: nil,
            bottom: passwordConfirmationTextField.topAnchor,
            trailing: nil,
            padding: .init(top: 0, left: 0, bottom: 20, right: 0),
            size: .init(width: 250, height: 50)
        )
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        passwordTextField
            .rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.password)
            .disposed(by: viewModel.bag)
        
        passwordConfirmationTextField
            .rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.passwordConfirmation)
            .disposed(by: viewModel.bag)
        
        activationButton.rx.tap.bind { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                strongSelf.viewModel.handleUserActivation()
            }
        }.disposed(by: viewModel.bag)
        
        viewModel.userIsActive
            .subscribe(onNext: { [weak self] isActive in
                DispatchQueue.main.async {
                    guard let strongSelf = self else { return }
                    if (isActive) {
                        strongSelf.dismiss(animated: true) {
                            TabBarService.shared.tabBarController.animateToTab(toIndex: 2)
                        }
                    }
                }
            }).disposed(by: viewModel.bag)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
