//
//  ApiDTO.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

class GenericServerResponse<T: Decodable>: Decodable {    
    let success: Bool
    let data: T
}
