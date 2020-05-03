//
//  StripePaymentParams.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 01/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

struct StripePaymentParams : Decodable {
    var paymentIntentId: String
    var clientSecret: String
}
