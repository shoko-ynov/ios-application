//
//  PaymentBreadcrumbViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol PaymentBreadcrumbViewModelling {
    var index: PublishSubject<IndexPath> { get }
    var bag: DisposeBag { get }
}

final class PaymentBreadcrumbViewModel: PaymentBreadcrumbViewModelling {
    let bag: DisposeBag
    let index: PublishSubject<IndexPath>
    
    init() {
        index = PublishSubject()
        bag = DisposeBag()
    }
}
