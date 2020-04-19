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
    var onSuccesfulLogin: (() -> Void)?
    var onErrorLogin: (() -> Void)?
    
    func login() {
        let userLogin = UserLoginDTO(mail: mailTextInput.value, password: passwordTextInput.value)
        
        service.login(user: userLogin, completionHandler: { result in
            switch result {
            case .success(let token):
                UserDefaults.standard.set(token.refreshToken, forKey: "refreshToken")
                UserDefaults.standard.set(token.token, forKey: "TOKEN")
                
                self.onSuccesfulLogin?()
            case .failure(let error as NSError):
                print("error", error)
                self.onSuccesfulLogin?()
            }
        })
    }
}
