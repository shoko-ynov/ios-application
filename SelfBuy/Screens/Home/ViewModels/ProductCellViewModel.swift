//
//  ProductCellViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

protocol ProductCellViewModelling {
    var product: Product { get }
}

final class ProductCellViewModel: ProductCellViewModelling {

    var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
}
