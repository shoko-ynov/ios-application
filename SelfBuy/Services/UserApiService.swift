//
//  UserApiService.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

final class UserApiService {
    let decoder = JSONDecoder()
    
    func getCurrentUser() -> Single<User> {
      return Single<User>.create { single in
            Request()
                .setPath("/me")
                .setMethod(.GET)
                .withAuthentication()
                .sendWithDecode(User.self) {
                    switch $0 {
                    case .success(let user):
                        print(user)
                        single(.success(user))
                    case .failure(let error):
                        single(.error(error))
                    }
            }
            
            return Disposables.create()
        }

    }
    
    func getUserCards() -> Single<[Card]> {
        return Single<[Card]>.create { single in
            Request()
                .setPath("/cards")
                .setMethod(.GET)
                .withAuthentication()
                .sendWithDecode([Card].self) {
                    switch $0 {
                    case .success(let cards):
                        print(cards)
                        single(.success(cards))
                    case .failure(let error):
                        print(error)
                        single(.error(error))
                    }
            }
            
            return Disposables.create()
        }
    }
    
    func activeUser(_ userActivationDto: UserActivationDTO, completion: @escaping (Result<NSNull, Error>) -> Void) {
        let request = Request()
        
        request
            .setPath("/users/activation")
            .setMethod(.POST)
            .setBody(userActivationDto)
            .send(completion: completion)
    }
    
    
    func updateUser(userData: UserEditDTO, id: String, completionHandler: @escaping (Result<NSNull, Error>) -> Void) {
        let request = Request()

        let json = [
            "\(userData.parameter)" : "\(userData.value)"
        ]

        request
            .setPath("/users/\(id)")
            .setMethod(.PUT)
            .setBody(json)
            .send(completion: completionHandler)
    }
}
