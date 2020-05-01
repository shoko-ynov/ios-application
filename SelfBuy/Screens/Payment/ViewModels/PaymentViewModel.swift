//
//  PaymentViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 26/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import RxSwift
import Foundation

protocol PaymentViewModelling {
    var bag: DisposeBag { get }
    var selectedCard: Card? { get set }
    var userOrderShipping: UserOrderShippingDTO? { get set }
    
    func setUserOrderShipping(_ user: UserOrderShippingDTO)
    func setSelectedCard(_ card: Card)
}

final class PaymentViewModel: PaymentViewModelling {
    var selectedCard: Card?
    var userOrderShipping: UserOrderShippingDTO?
    let bag: DisposeBag
        
    init() {
        bag = DisposeBag()
        
        DispatchQueue.main.async {
            CardRepository.shared.synchronizeCards()
        }
    }
    
    func setUserOrderShipping(_ user: UserOrderShippingDTO) {
         self.userOrderShipping = user
     }
    
    func setSelectedCard(_ card: Card) {
        self.selectedCard = card
    }
}
