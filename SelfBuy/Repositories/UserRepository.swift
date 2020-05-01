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
    
    let userSubject: BehaviorSubject<User?>
    private var service: AuthAPIService
    
    init() {
        self.userSubject = BehaviorSubject(value: nil)
        self.service = AuthAPIService()
    }
    
    func synchronizeUser(onSuccess: @escaping () -> Void) {
        if AuthenticationManager.hasToken() {
            service.getMe() { [weak self] in
                guard let strongSelf = self else { return }
                
                switch $0 {
                case .success(let user):
                    strongSelf.userSubject.onNext(user)
                    onSuccess()
                case .failure(_):
                    strongSelf.userSubject.onNext(nil)
                }
            }
        }
    }
    
    func getUser() -> User? {
        do {
            return try userSubject.value()
        } catch {
            return nil
        }
    }
    
    func disconnect() {
        userSubject.onNext(nil)
    }
}
