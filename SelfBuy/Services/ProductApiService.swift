//
//  ProductApiService.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

final class ProductApiService {
    let decoder = JSONDecoder()
    
    func getAllProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        AF.request("\(Config.baseApi)/products", method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try self.decoder.decode(ProductsDTO.self, from: data)
                        completion(.success(decodedData.data))
                    } catch let error {
                        print(error)
                    }
                case.failure(let error):
                    completion(.failure(error))
                }
        }
        
    }
    
    func getAllProducts() -> Single<[Product]> {
        return Single<[Product]>.create { single in
            AF.request("\(Config.baseApi)/products", method: .get)
                .validate()
                .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try self.decoder.decode(ProductsDTO.self, from: data)
                        single(.success(decodedData.data))
                    } catch let error {
                        single(.error(error))
                    }
                case.failure(let error):
                    single(.error(error))
                }
                
            }
            
            return Disposables.create()
        }
        
    }
    
}
