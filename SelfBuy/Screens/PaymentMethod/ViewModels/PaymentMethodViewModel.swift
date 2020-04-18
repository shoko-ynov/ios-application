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
    func fetchData() -> Single<[Card]>
}

final class PaymentMethodViewModel: PaymentMethodViewModelling {
    var service: UserApiService = UserApiService()
    
    func fetchData() -> Single<[Card]> {
        return service.getUserCards()
    }
}
