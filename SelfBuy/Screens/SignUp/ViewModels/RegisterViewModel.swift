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
    let passwordTextInput = BehaviorRelay<String>(value: "")
    
    func register() {
        print("register")
        print(mailTextInput.value)
    }
}
