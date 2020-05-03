//
//  LoginViewController.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//
import UIKit
import RxSwift

class LoginViewController: PresentableViewController {
    private var loginBtn = SolidButton(text: "Connexion")
    
    private var forgottenPassword: UIButton = {
        let button:UIButton = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Mot de passe oublié ?", for: .normal)
        button.titleLabel?.setToBold(size: 13)
        
        return button
    }()
    
    private var registerBtn = GhostButton(text: "Inscription")
    
    private var emailTextField: UITextField = {
        let input = UITextField()
        input.placeholder = " Email"
        input.backgroundColor = .white
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .black
        input.textColor = .black
        return input
    }()
    
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
    
    let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onDismiss = {}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        onDismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(passwordTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(loginBtn)
        self.view.addSubview(registerBtn)
        self.view.addSubview(forgottenPassword)
        
        forgottenPassword.anchor(
            top: nil,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            centerAnchor: view.centerXAnchor,
            padding: .init(top: 0, left: 0, bottom: 50, right: 0)
        )
        
        registerBtn.anchor(
            top: nil,
            bottom: forgottenPassword.topAnchor,
            centerAnchor: view.centerXAnchor,
            padding: .init(top: 0, left: 0, bottom: 25, right: 0)
        )
        
        loginBtn.anchor(
            top: nil,
            bottom: registerBtn.topAnchor,
            centerAnchor: view.centerXAnchor,
            padding: .init(top: 0, left: 0, bottom: 10, right: 0)
        )
        
        passwordTextField.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: loginBtn.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 25, bottom: 80, right: 25),
            size: .init(width: 0, height: 50)
        )
        
        emailTextField.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: passwordTextField.topAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 25, bottom: 10, right: 25),
            size: .init(width: 0, height: 50)
        )
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        loginBtn.rx.tap.bind { _ in
            DispatchQueue.main.async {
                self.viewModel.login()
            }
        }.disposed(by: self.viewModel.bag)
        
        registerBtn.rx.tap.bind { _ in
            DispatchQueue.main.async {
                let vc = RegisterViewController(viewModel: RegisterViewModel())
                self.present(vc, animated: true)
            }
        }.disposed(by: self.viewModel.bag)
        self.view.backgroundColor = .lightGray
        
        emailTextField
            .rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.mailTextInput)
            .disposed(by: viewModel.bag)
        
        passwordTextField
            .rx
            .text
            .skip(1)
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.passwordTextInput)
            .disposed(by: viewModel.bag)
        
        viewModel.onSuccesfulLogin = {
            DispatchQueue.main.async {
                UserRepository.shared.synchronizeUser(onSuccess: { [weak self] in
                    DispatchQueue.main.async {
                        self?.dismiss(animated: true)
                    }
                })
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
