//
//  CardRepository.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 23/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import UIKit
import RxSwift

final class CardRepository {
    
    static let shared = CardRepository()
    
    let cardsSubject: BehaviorSubject<[Card]> = BehaviorSubject(value: [])
    let service = UserApiService()
    
    func synchronizeCards() -> Void {
        service.getUserCards { [weak self] in
            guard let strongSelf = self else { return }
            
            switch $0 {
            case .success(let cards):
                strongSelf.cardsSubject.onNext(cards)
            case .failure(let error):
                strongSelf.cardsSubject.onNext([])
                print(error)
            }
        }
    }
    
    func getCards() -> [Card]{
        do {
            return try cardsSubject.value()
        } catch {
            return []
        }
    }
    
    func getCard(_ index: IndexPath) -> Card {
        return getCards()[index.row]
    }
}
