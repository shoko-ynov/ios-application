//
//  PayDTO.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 01/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

struct PayProductDTO: Encodable {
    var productId: String
    var quantity: Int
}

struct PayDTO: Encodable {
    var products: [PayProductDTO]
    var cardId: String
}
