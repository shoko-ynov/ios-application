//
//  UserActivationViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 20/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

protocol UserActivationViewModelling {
    var key: String { get }
    var userId: String { get }
}

class UserActivationViewModel: UserActivationViewModelling {
    let key: String
    let userId: String
    
    init(key: String, userId: String) {
        self.key = key
        self.userId = userId
        
        print(self.key)
        print(self.userId)
    }
}
