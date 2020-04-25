//
//  UserActivationDTO.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

struct UserActivationDTO: Encodable {
    let userId: String
    let activationKey: String
    let password: String
}
