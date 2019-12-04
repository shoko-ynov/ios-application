//
//  ApiDTO.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct GenericServerResponse <T> where T: Decodable {

    let success: Bool
    let data: T
    let errors: [String]
}
