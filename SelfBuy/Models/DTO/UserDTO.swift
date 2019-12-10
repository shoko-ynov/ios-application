//
//  UserDTO.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 10/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct UserLoginDTO : Encodable {
    var mail: String
    var password : String
}
