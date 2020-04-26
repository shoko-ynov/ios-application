//
//  AccountViewModel.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

struct UserData {
    let label, iconName: String
}

protocol AccountViewModelling {
    var repository: UserRepository { get }
    var staticUserData: [UserData] { get }
    var bag: DisposeBag { get }
}

final class AccountViewModel: AccountViewModelling {
    
    let staticUserData = [
        UserData(label: "Prénom", iconName: "person.fill"),
        UserData(label: "Nom", iconName: "person.fill"),
        UserData(label: "Email", iconName: "envelope.fill"),
        UserData(label: "Adresse", iconName: "house.fill"),
        UserData(label: "Ville", iconName: "house.fill"),
        UserData(label: "Code Postal", iconName: "house.fill"),
    ]
    
    let repository: UserRepository = UserRepository.shared
    
    let bag = DisposeBag()
    /*func showData() {
        _ = service.getMe() { [weak user] in
            switch $0 {
                case .success(let data):
                    user?.accept(data)
                case .failure(let error):
                    print("error \(error)")
            }
        }
    }*/
}
