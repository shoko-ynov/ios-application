//
//  SignInViewController.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//
import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
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
    
    private var loginTextField: UITextField = {
        let input = UITextField(frame: CGRect(x: -10, y: 350,width:250 ,height: 50))
        input.placeholder = " Email"
        input.backgroundColor = .white
        input.layer.cornerRadius = 15
        input.borderStyle = UITextField.BorderStyle.roundedRect
        
        return input
    }()
    
    private var passwordTextField: UITextField = {
        let password = UITextField(frame: CGRect(x: -10, y: 405,width:250 ,height: 50))
        password.placeholder = " Password"
        password.backgroundColor = .white
        password.isSecureTextEntry = true
        password.layer.cornerRadius = 15
        password.borderStyle = UITextField.BorderStyle.roundedRect
        
        return password
    }()
    
    @objc func buttonClicked() {
        let mail = loginTextField.text
        let password = passwordTextField.text
        let userLogin = UserLogin.init(mail: mail!, password: password!)
        
        let service: AuthAPIService = AuthAPIService()
        service.login(user: userLogin, completionHandler: { result in
            switch result {
            case .success(let tokenObject as TokenDTO):
                print(tokenObject)
            case .failure(let error as NSError):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            default:
                print("default")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginLabel.center.x = self.view.center.x
        loginTextField.center.x = self.view.center.x
        passwordTextField.center.x = self.view.center.x
        loginBtn.center.x = self.view.center.x
        registerBtn.center.x = self.view.center.x
        forgottenPassword.center.x = self.view.center.x
        
        registerBtn.frame = CGRect(x: self.view.frame.size.width - 100, y: 200, width: 250, height: 50)
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = .lightGray
        
        loginBtn.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginTextField)
        self.view.addSubview(loginLabel)
        self.view.addSubview(loginBtn)
        self.view.addSubview(registerBtn)
        self.view.addSubview(forgottenPassword)
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
