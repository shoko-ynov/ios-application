//
//  ProductDetailViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 30/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

protocol ProductDetailViewModelling {
    var product: Product { get }
}

final class ProductDetailViewModel: ProductDetailViewModelling {
    
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
}
