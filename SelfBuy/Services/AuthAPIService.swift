//
//  AuthAPIService.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 04/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

final class AuthAPIService{
    
    func register(mail: RegisterDTO, completionHandler: @escaping (Result<NSNull, Error>) -> Void) {
        let request = Request()
        
        request
            .setPath("/users")
            .setMethod(.POST)
            .setBody(mail)
            .send(completion: completionHandler)
    }
    
    func getMe(completion: @escaping (Result<User, Error>) -> Void){
        let request = Request()
        
        request
            .setPath("/me")
            .setMethod(.GET)
            .withAuthentication()
            .sendWithDecode(User.self, completion: completion)
    }
    
    
    func refreshToken(completion: @escaping (Result<Token, Error>) -> Void) {
        let request = Request()
        let refreshTokenSaved = AuthenticationManager.getRefreshToken()
        
        guard let strongRefreshToken = refreshTokenSaved else {
            let error = NSError(domain: "Empty refresh toekn", code: 401)
            completion(.failure(error))
            return
        }
        
        let token = RefreshTokenDTO(refreshToken: strongRefreshToken)
    
        request
            .setPath("/auth/refresh")
            .setMethod(.POST)
            .setBody(token)
            .disableCanRefreshToken()
            .sendWithDecode(Token.self, completion: completion)
    }
    
    func login(user: UserLoginDTO, completionHandler: @escaping (Result<Token, Error>) -> Void) {
        let request = Request()
        
        request
            .setPath("/auth")
            .setMethod(.POST)
            .setBody(user)
            .sendWithDecode(Token.self, completion: completionHandler)
    }
    
}
