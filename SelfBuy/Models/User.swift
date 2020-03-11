//
//  User.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct User : Codable {
    let isAdmin: Bool
    let _id: String
    let mail: String
    let active: Bool
    let registrationDate: Int
}