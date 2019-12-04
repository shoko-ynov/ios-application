//
//  Product.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct Product: Decodable {
    var _id: String
    var name: String
    var category: String?
    var price: Float
    var description: String
    var images: [String]
}

struct ProductsDTO: Decodable {
    var success: Bool
    var data: [Product]
}
