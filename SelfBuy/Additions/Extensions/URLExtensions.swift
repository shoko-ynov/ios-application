//
//  URLExtensions.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
