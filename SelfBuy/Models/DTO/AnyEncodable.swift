//
//  AnyEncodable.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 10/12/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

struct AnyEncodable: Encodable {

    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
