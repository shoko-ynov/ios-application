//
//  UserOrderShippingDTO.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 01/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

struct UserOrderShippingDTO : Encodable {
    var firstName: String
    var lastName: String
    var address: String
    var postalCode: Int
    var city: String
}
