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
                .send(User.self) {
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
                .send([Card].self) {
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
    
    
    func updateUser(user: User, id: Int, completionHandler: @escaping (Result<Token, Error>) -> Void) {
          let request = Request()
          
          request
              .setPath("users/:\(id)")
              .setMethod(.POST)
              .setBody(user)
              .send(RegisterResponseDTO.self) {
                  switch $0 {
                  case .success(let data):
                      print(data)
                  case .failure(let error):
                      print(error)
                  }
          }
      }
}
