//
//  CartCellViewModel.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

protocol CartCellViewModelling {
    var cartItem: CartItem { get }
}

final class CartCellViewModel : CartCellViewModelling {

    let cartItem: CartItem
    
    init(cartItem: CartItem) {
        self.cartItem = cartItem
    }
    
}
