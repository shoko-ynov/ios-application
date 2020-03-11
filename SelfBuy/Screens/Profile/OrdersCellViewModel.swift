//
//  OrdersCellViewModel.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 10/01/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

protocol OrdersCellViewModelling {
    var cartItem: CartItem { get }
}

final class OrdersCellViewModel : OrdersCellViewModelling {

    let cartItem: CartItem
    
    init(cartItem: CartItem) {
        self.cartItem = cartItem
    }
    
}

