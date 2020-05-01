//
//  UserActivationViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol UserActivationViewModelling {
    var key: String { get }
    var userId: String { get }
    var bag: DisposeBag { get }
    var password: BehaviorRelay<String> { get }
    var passwordConfirmation: BehaviorRelay<String> { get }
    var userService: UserApiService { get }
    var userIsActive: BehaviorSubject<Bool> { get }
    
    func handleUserActivation() -> Void
}

class UserActivationViewModel: UserActivationViewModelling {
    let bag: DisposeBag
    let password: BehaviorRelay<String>
    let passwordConfirmation: BehaviorRelay<String>
    let userService: UserApiService
    let userIsActive: BehaviorSubject<Bool>
    
    let key: String
    let userId: String
    
    init(key: String, userId: String) {
        self.key = key
        self.userId = userId
        self.bag = DisposeBag()
        self.password = BehaviorRelay(value: "")
        self.passwordConfirmation = BehaviorRelay(value: "")
        self.userService = UserApiService()
        self.userIsActive = BehaviorSubject(value: false)
    }
    
    func handleUserActivation() {
        
        if (password.value != passwordConfirmation.value) {
            return
        }
        
        let dto = UserActivationDTO(userId: userId, activationKey: key, password: password.value)
        
        userService.activeUser(dto) { [weak self] in
            guard let strongSelf = self else { return }
            
            switch($0) {
            case .success(_):
                strongSelf.userIsActive.onNext(true)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
