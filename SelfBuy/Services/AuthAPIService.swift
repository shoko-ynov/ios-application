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
                    print(data)
                case .failure(let error):
                    print("error \(error)")
                }
        }
    }
    
    func refreshToken(){
        let request = Request()
        let refreshTokenSaved = UserDefaults.standard.string(forKey: "refreshToken") ?? ""
        
        let token = RefreshTokenDTO(refreshToken: refreshTokenSaved)
    
        request
            .setPath("/auth/refresh")
            .setMethod(.POST)
            .setBody(token)
            .send(Token.self) {
              switch $0 {
              case .success(let data):
                  print(data)
              case .failure(let error):
                print("error \(error)")
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
                    let userDefaults = UserDefaults.standard
                    
                    userDefaults.set(token.refreshToken, forKey: "refreshToken")
                    userDefaults.set(token.token, forKey: "TOKEN")
                    
                    completionHandler(Result.success(token))
                case .failure(let error):
                    completionHandler(Result.failure(error))
                }
        }
    }
    
}
