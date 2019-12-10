//
//  AuthAPIService.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 04/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class AuthAPIService{
    
    func login(user: UserLoginDTO, completionHandler: @escaping (Result<Token, Error>) -> Void) {
        
        let request = Request()
        
        request
            .setPath("/auth")
            .setMethod(.POST)
            .setBody(user)
            .send(Token.self) {
                switch $0 {
                case .success(let token):
                    print(token)
                case .failure(let error):
                    print(error)
                }
        }
            
    }
}
