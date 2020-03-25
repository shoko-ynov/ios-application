//
//  User.swift
//  SelfBuy
//
//  Created by Coline Rousselot on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct User : Codable {
//    let isAdmin: Bool
    let _id: String
    let mail: String
    let active: Bool
    let firstName: String
    let lastName: String
    let registrationDate: Date
    let address: String
    let postalCode: String
    let city: String
}
