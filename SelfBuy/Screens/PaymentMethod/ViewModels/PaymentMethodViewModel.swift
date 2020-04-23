//
//  PaymentMethodViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 18/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentMethodViewModelling {
    var service: UserApiService { get }
    var bag: DisposeBag { get }
    var repository: CardRepository { get }
}

final class PaymentMethodViewModel: PaymentMethodViewModelling {
    let repository: CardRepository
    let service: UserApiService = UserApiService()
    let bag: DisposeBag = DisposeBag()
    
    init() {
        repository = CardRepository.shared
    }
}
