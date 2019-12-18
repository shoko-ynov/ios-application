//
//  RegisterViewController.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 18/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    private var emailTextField: UITextField = {
        let email = UITextField(frame: CGRect(x: -10, y: 335,width:250 ,height: 50))
        email.placeholder = " Email"
        email.backgroundColor = .white
        email.isSecureTextEntry = true
        email.layer.cornerRadius = 15
        email.borderStyle = UITextField.BorderStyle.roundedRect
        email.tintColor = .black
        email.textColor = .black
        
        return email
    }()
    
    private var registerBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 410, width: 250, height:50))
        button.backgroundColor = .primary
        button.layer.cornerRadius = 25
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)
        button.setTitle("Register", for: .normal)
        
        return button
    }()
    
    let viewModel: RegisterViewModel
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.center.x = self.view.center.x
        registerBtn.center.x = self.view.center.x
        
        self.view.backgroundColor = .lightGray
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.registerBtn)
        
        registerBtn.rx.tap.bind { _ in
            self.viewModel.register()
        }.disposed(by: self.viewModel.bag)
        
        emailTextField
            .rx
            .text
            .map({ $0.unsafelyUnwrapped })
            .asObservable()
            .bind(to: viewModel.mailTextInput)
            .disposed(by: viewModel.bag)
    }
}
