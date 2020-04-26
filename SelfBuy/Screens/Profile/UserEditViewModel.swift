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
    
    func updateUser() -> Void
}

final class UserEditViewModel: UserEditViewModelling {
    var bag: DisposeBag
    
    var valueName: String
    
    var value: BehaviorRelay<String>
    
    var userId: String
    
    
    init(valueName: String, value: String, userId: String) {
        self.valueName = valueName
        self.value = BehaviorRelay(value: value)
        self.userId = userId
        self.bag = DisposeBag()
    }
    
    func updateUser() {
        
    }
}
