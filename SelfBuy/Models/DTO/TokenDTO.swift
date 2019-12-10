//
//  TokenDTO.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct Token : Codable {
    let token: String
    let userId: String
    let refreshToken: String
}

struct TokenDTO: Decodable {
    var success: Bool
    var data: Token
}
