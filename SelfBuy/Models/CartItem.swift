//
//  CartItem.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct CartItem: Decodable {
    var product: Product
    var quantity: Int
}
