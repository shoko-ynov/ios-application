//
//  UserDetailViewModel.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

struct UserData {
    let label, iconName: String
}

class UserViewModel {

    let user = BehaviorRelay<User?>(value: nil)
    let service: AuthAPIService = AuthAPIService()
    
    let staticUserData = [
        UserData(label: "Name", iconName: "person.fill"),
        UserData(label: "Email", iconName: "envelope.fill"),
        UserData(label: "Address", iconName: "house.fill")
    ]
    
    func showData() {
        _ = service.getMe() { [weak user] in
            switch $0 {
                case .success(let data):
                    user?.accept(data)
                case .failure(let error):
                    print("error \(error)")
            }
        }
    }
}
