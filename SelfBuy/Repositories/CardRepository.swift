//
//  CardRepository.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

final class CardRepository {
    
    static let shared = CardRepository()
    
    var cards: [Card] = []
    var cardsPublishSubject: PublishSubject<[Card]> = PublishSubject()
    let service = UserApiService()
    
    func synchronizeCards() -> Void {
        service.getUserCards { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let cards):
                strongSelf.cards = cards
                strongSelf.cardsPublishSubject.onNext(cards)
            case .failure(let error):
                strongSelf.cards = []
                strongSelf.cardsPublishSubject.onNext([])
                print(error)
            }
        }
    }
    
}
