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
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func login(user: UserLogin, completionHandler: @escaping (Result<TokenDTO, Error>) -> Void) {
//        let parameters: [String: String] = [
//            "mail" : user.mail,
//            "password" : user.password
//        ]
            
        AF.request("\(Config.baseApi)/auth", method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(contentType: ["application/json"])
            .responseData { response in
                print(response)
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try self.decoder.decode(TokenDTO.self, from: data)
                        completionHandler(.success(decodedData))
                    } catch let error {
                        print(error)
                    }
                case.failure(let error):
                    completionHandler(.failure(error))
                }
        }
    }
}
