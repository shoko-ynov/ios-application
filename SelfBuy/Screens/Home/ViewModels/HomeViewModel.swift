//
//  HomeViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 07/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewModelling: class {
    var service: ProductApiService { get }
    func fetchData() -> Single<[Product]>
}

final class HomeViewModel: HomeViewModelling {
    
    var service: ProductApiService = ProductApiService()
    
    func fetchData() -> Single<[Product]> {
        return service.getAllProducts()
    }
    
}
