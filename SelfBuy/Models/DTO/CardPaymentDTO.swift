//
//  CardPaymentDTO.swift
//  SelfBuy
//
//  Created by Léo GIGT on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

struct CardPaymentDTO : Encodable {
    var number : String
    var monthExpiration : Int
    var yearExpiration : Int
    var cvc : String
    var name : String
}
