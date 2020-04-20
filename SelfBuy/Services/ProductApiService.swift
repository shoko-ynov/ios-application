//
//  ProductApiService.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

final class ProductApiService {
    let decoder = JSONDecoder()
    
    func getAllProducts() -> Single<[Product]> {
        return Single<[Product]>.create { single in
            Request()
                .setPath("/products")
                .setMethod(.GET)
                .sendWithDecode([Product].self) {
                    switch $0 {
                    case .success(let products):
                        single(.success(products))
                    case .failure(let error):
                        single(.error(error))
                    }
            }
            
            return Disposables.create()
        }
        
    }
    
}
