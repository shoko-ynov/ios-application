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
    
    func register(mail: RegisterDTO,completionHandler: @escaping (Result<Token, Error>) -> Void) {
        let request = Request()
        
        request
            .setPath("/users")
            .setMethod(.POST)
            .setBody(mail)
            .send(RegisterResponseDTO.self) {
                switch $0 {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func getMe(){
        let request = Request()
        
        request
            .setPath("/me")
            .setMethod(.GET)
            .withAuthentication()
            .send(User.self) {
                switch $0 {
                case .success(let data):
                    print("là")
                    print(data)
                case .failure(let error):
                    print("ici")
                    print(error)
                }
        }
    }
    
    func login(user: UserLoginDTO, completionHandler: @escaping (Result<Token, Error>) -> Void) {
        let request = Request()
        
        request
            .setPath("/auth")
            .setMethod(.POST)
            .setBody(user)
            .send(Token.self) {
                switch $0 {
                case .success(let token):
                    UserDefaults().set(token.refreshToken, forKey: "refreshToken")
                    UserDefaults().set(token.token, forKey: "TOKEN")
                case .failure(let error):
                    print(error)
                }
        }
    }
    
}
