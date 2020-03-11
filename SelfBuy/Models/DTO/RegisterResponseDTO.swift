//
//  RegisterResponseDTO.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 18/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct RegisterResponseDTO : Decodable {
    let userExist: Bool
    let mailIsSent: Bool
}
