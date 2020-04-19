//
//  RegisterViewModel.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 18/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class RegisterViewModel
{
    let service: AuthAPIService = AuthAPIService()
    let bag = DisposeBag()
    
    let mailTextInput = BehaviorRelay<String>(value: "")
    
    func register() {
        let userRegister = RegisterDTO(mail: mailTextInput.value)
        
        service.register(mail: userRegister, completionHandler: { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(let error as NSError):
                print(error)
            default:
                print("default")
            }
        })
    }
}
