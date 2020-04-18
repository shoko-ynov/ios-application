//
//  Card.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 18/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

struct Card: Decodable {
    var _id: String
    var name: String
    var band: String
    var last4: String
    var expMonth: Int
    var expYear: Int
    var isDefaultCard: Bool
}
