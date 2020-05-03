//
//  RegisterViewController.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 18/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import UIKit

class RegisterViewController: PresentableViewController {
    private var emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = " Email"
        email.backgroundColor = .white
        email.layer.cornerRadius = 15
        email.borderStyle = UITextField.BorderStyle.roundedRect
        email.tintColor = .black
        email.textColor = .black
        
        return email
    }()
    
    private var registerBtn = SolidButton(text: "S'inscrire")
    
    private var backgroundImg: UIImageView = {
        let image = UIImage(named: "RegisterBackgroundImage")
        let imageView = UIImageView(image: image)
        
        return imageView
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
        
        self.backgroundImg.frame = CGRect(x: self.view.frame.size.width - 290, y: self.view.frame.size.height - 170, width: 250, height:135)
        
        self.view.backgroundColor = .lightGray
        self.view.addSubview(self.emailTextField)
        self.view.addSubview(self.registerBtn)
        self.view.addSubview(self.backgroundImg)
        
        emailTextField.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: view.centerYAnchor,
            trailing: view.trailingAnchor,
            padding: .init(top: 0, left: 25, bottom: 0, right: 25),
            size: .init(width: 0, height: 50)
        )
        
        registerBtn.anchor(
            top: emailTextField.bottomAnchor,
            bottom: nil,
            centerAnchor: view.centerXAnchor,
            padding: .init(top: 50, left: 0, bottom: 0, right: 0)
        )
        
        registerBtn.rx.tap.bind { [weak self] _ in
            guard let strongSelf = self else { return }
            
            strongSelf.viewModel.register {
                switch $0 {
                case .success(_):
                    strongSelf.dismiss(animated: true)
                case .failure(let error):
                    print(error)
                }
            }
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
