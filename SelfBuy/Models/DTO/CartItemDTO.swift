//
//  CartItemDTO.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 18/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

struct CartItemDTO: Encodable {
    let productId: String;
    var quandtity: Int;
}
