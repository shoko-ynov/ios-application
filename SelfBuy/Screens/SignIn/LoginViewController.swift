//
//  LoginViewController.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//
import UIKit
import RxSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
    private var loginLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 290, width: 80, height: 41))
        label.font = UIFont(name: "Helvetica", size: 32)
        label.textColor = .black
        label.text = "Login"
        
        return label
     }()
    
    private var loginBtn: UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 475, width: 250, height: 50))
        button.backgroundColor = .primary
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 0
        button.setTitle("Connect", for: .normal)
        
        return button
    }()
    
    private var forgottenPassword: UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 525, width: 250, height: 50))
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Forgotten password ?", for: .normal)
        
        return button
    }()
    
    private var registerBtn: UIButton = {
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 200, width: 250, height: 50))
        button.backgroundColor = .primary
        button.layer.cornerRadius = 25
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)
        button.setTitle("Register", for: .normal)
        
        return button
    }()
    
    private var emailTextField: UITextField = {
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 50))
        input.placeholder = " Email"
        input.backgroundColor = .white
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        input.tintColor = .black
        input.textColor = .black
        return input
    }()
    
    private var passwordTextField: UITextField = {
        let password = UITextField(frame: CGRect(x: -10, y: 405,width:250 ,height: 50))
        password.placeholder = " Password"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginLabel.center.x = self.view.center.x
        emailTextField.center.x = self.view.center.x
        passwordTextField.center.x = self.view.center.x
        loginBtn.center.x = self.view.center.x
        registerBtn.center.x = self.view.center.x
        forgottenPassword.center.x = self.view.center.x
        
//        Constraints
//        loginLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        registerBtn.frame = CGRect(x: self.view.frame.size.width - 100, y: 200, width: 250, height: 50)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        loginBtn.rx.tap.bind { _ in
            self.viewModel.login()
        }.disposed(by: self.viewModel.bag)
        
        registerBtn.rx.tap.bind { _ in
            let vc = RegisterViewController(viewModel: RegisterViewModel())
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: self.viewModel.bag)
        
        self.view.addSubview(passwordTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(loginLabel)
        self.view.addSubview(loginBtn)
        self.view.addSubview(registerBtn)
        self.view.addSubview(forgottenPassword)
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
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
