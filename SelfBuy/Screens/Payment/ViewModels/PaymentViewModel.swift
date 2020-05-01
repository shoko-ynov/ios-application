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
    
    func setSelectedCard(_ card: Card)
}

final class PaymentViewModel: PaymentViewModelling {
    var selectedCard: Card?
    let bag: DisposeBag
        
    init() {
        bag = DisposeBag()
        
        DispatchQueue.main.async {
            CardRepository.shared.synchronizeCards()
        }
    }
    
    func setSelectedCard(_ card: Card) {
        self.selectedCard = card
    }
}
