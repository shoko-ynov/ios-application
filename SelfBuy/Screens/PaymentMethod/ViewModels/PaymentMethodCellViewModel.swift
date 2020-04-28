//
//  CardCellViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 18/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

protocol PaymentMethodCellViewModelling {
    var card: Card { get }
    var bag: DisposeBag { get }
    
    func deleteMethod() -> Void
}

final class PaymentMethodCellViewModel: PaymentMethodCellViewModelling {
    var bag: DisposeBag
    var card: Card
    
    init(card: Card) {
        self.card = card
        self.bag = DisposeBag()
    }
    
    func deleteMethod() -> Void {
        PaymentApiService().removeCard(card: card) {
            switch $0 {
            case .success(_):
                CardRepository.shared.synchronizeCards()
            case .failure(let error):
                print(error)
            }
        }
    }
}
