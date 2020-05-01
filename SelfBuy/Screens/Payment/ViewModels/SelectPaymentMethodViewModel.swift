//
//  SelectPaymentMethodViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 01/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol SelectPaymentMethodViewModelling {
    var repository: CardRepository { get }
    var bag: DisposeBag { get }
    var numberOfItems: Int { get }
    var selectedCard: PublishSubject<Card> { get }
    
    func getItem(_ indexPath: IndexPath) -> PaymentMethodCellViewModel
    func selectCard(_ cardIndex: IndexPath)
}

final class SelectPaymentMethodViewModel: SelectPaymentMethodViewModelling {
    let selectedCard: PublishSubject<Card>
    let bag: DisposeBag
    let repository: CardRepository
    
    
    var numberOfItems: Int {
        return repository.getCards().count
    }
    
    init() {
        repository = CardRepository.shared
        bag = DisposeBag()
        selectedCard = PublishSubject()
    }
    
    func getItem(_ indexPath: IndexPath) -> PaymentMethodCellViewModel {
        return PaymentMethodCellViewModel(card: repository.getCard(indexPath))
    }
    
    func selectCard(_ cardIndex: IndexPath) {
        selectedCard.onNext(repository.getCard(cardIndex))
    }
}
