//
//  UserRepository.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 27/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

final class UserRepository {
    
    static let shared = UserRepository()
    
    var user: User?
    let userSubject: BehaviorSubject<User?>
    private var service: AuthAPIService
    
    init() {
        self.userSubject = BehaviorSubject(value: nil)
        self.service = AuthAPIService()
    }
    
    func synchronizeUser() {
        if AuthenticationManager.hasToken() {
            service.getMe() { [weak self] in
                guard let strongSelf = self else { return }
                
                switch $0 {
                case .success(let user):
                    strongSelf.user = user
                    strongSelf.userSubject.onNext(user)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
