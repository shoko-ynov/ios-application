//
//  StripePaymentIntent.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 03/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

enum StripePayementIntentStatus: String, Decodable {
    case succeeded, requires_action, requires_payment_method
}

struct StripeNextActionRedirectToURL: Decodable {
    var url: String
}

struct StripeNextAction: Decodable {
    var type: String
    var redirect_to_url: StripeNextActionRedirectToURL?
}

struct StripePaymentIntent: Decodable {
    var status: StripePayementIntentStatus
    var next_action: StripeNextAction?
}
