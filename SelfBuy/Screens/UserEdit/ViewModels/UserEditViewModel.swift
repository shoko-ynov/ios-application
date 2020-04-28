//
//  UserEditViewModel.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

protocol UserEditViewModelling {
    var valueName: String { get }
    var value: BehaviorRelay<String> { get }
    var bag: DisposeBag { get }
    var userId: String { get }
    var parameter: String { get }
    var service: UserApiService { get }
    func updateUser(valueName: String, value: String, userId: String, parameter: String)
}

final class UserEditViewModel: UserEditViewModelling {
    var valueName: String
    var value: BehaviorRelay<String>
    var userId: String
    var parameter: String
    var service = UserApiService()
    var bag: DisposeBag
    
    init(valueName: String, value: String, userId: String, parameter: String) {
        self.valueName = valueName
        self.value = BehaviorRelay(value: value)
        self.userId = userId
        self.parameter = parameter
        self.bag = DisposeBag()
        self.service = UserApiService()
    }
    
    func updateUser(valueName : String, value: String, userId: String, parameter: String) {
        
        let user = UserEditDTO(
               parameter: parameter,
               value: value
       )

        service.updateUser(userData: user, id: userId, parameter: parameter){ (result) in
            switch result {
            case .success(let user):
                print("success")
                print(user)
            case .failure(let error as NSError):
                print(error)
            default:
                print("default")
            }
        }
    }

}
