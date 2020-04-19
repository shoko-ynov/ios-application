//
//  ProductDetailViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductDetailViewModelling {
    var product: Product { get }
    var bag: DisposeBag { get }
}

final class ProductDetailViewModel: ProductDetailViewModelling {
    
    let bag: DisposeBag
    let product: Product
    
    init(product: Product) {
        self.product = product
        self.bag = DisposeBag()
    }
    
}
