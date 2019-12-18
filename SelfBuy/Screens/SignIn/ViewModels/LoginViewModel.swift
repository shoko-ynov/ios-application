//
//  SignInViewModel.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 18/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class LoginViewModel
{
    let service: AuthAPIService = AuthAPIService()
    let bag = DisposeBag()
    
    let mailTextInput = BehaviorRelay<String>(value: "")
    let passwordTextInput = BehaviorRelay<String>(value: "")
    
    func login()
    {
        print(mailTextInput)
        print(passwordTextInput)
        
        let userLogin = UserLoginDTO(mail: "", password: "")
        
        service.login(user: userLogin, completionHandler: { result in
            switch result {
            case .success(let tokenObject):
                print(tokenObject)
            case .failure(let error as NSError):
            //               let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            //               alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            //               self.present(alert, animated: true, completion: nil)
                print("error: %@", error)
            default:
                print("default")
            }
        })
    }
    
    func register()
    {
        print("register")
        print(mailTextInput.value)
    }
}
