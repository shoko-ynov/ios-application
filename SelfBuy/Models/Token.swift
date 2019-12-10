//
//  TokenDTO.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct Token : Decodable {
    let token: String
    let refreshToken: String
}
