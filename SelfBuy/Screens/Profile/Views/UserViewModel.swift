//
//  UserDetailViewModel.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol UserViewModelling: class {
   
    var service: UserApiService { get }
    func fetchData() -> User
}

final class UserViewModel: UserViewModelling {
    
    var service: UserApiService = UserApiService()
    
    let user: User
    
    init(user: User) {
         self.user = user
     }
    
    func fetchData() -> User {
        return service.getCurrentUser()
    }
    
}
