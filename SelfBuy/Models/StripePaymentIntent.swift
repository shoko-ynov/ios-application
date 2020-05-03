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

struct StripeNextActionUseStripeSDK: Decodable {
    var type: String
    var stripe_js: String
}

struct StripeNextAction: Decodable {
    var type: String
    var use_stripe_sdk: StripeNextActionUseStripeSDK?
}

struct StripePaymentIntent: Decodable {
    var status: StripePayementIntentStatus
    var next_action: StripeNextAction?
}
