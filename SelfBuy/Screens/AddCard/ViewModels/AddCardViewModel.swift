//
//  CardViewModel.swift
//  SelfBuy
//
//  Created by Léo GIGT on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import Stripe

protocol AddCardViewModelling {
    var bag: DisposeBag { get }
    var service: PaymentApiService { get }
    var nameTextInput: BehaviorRelay<String> { get }
    
    func createCard(cardParams: STPPaymentMethodCardParams, completion: @escaping (Result<NSNull, Error>) -> Void) -> Void
    func linkCardToUser(stripeCard: StripeCard, completion: @escaping (Result<NSNull, Error>) -> Void) -> Void
}

final class AddCardViewModel: AddCardViewModelling {
    let bag = DisposeBag()
    let service = PaymentApiService()
    
    let nameTextInput = BehaviorRelay<String>(value: "")
    
    func createCard(cardParams : STPPaymentMethodCardParams, completion: @escaping (Result<NSNull, Error>) -> Void) -> Void {
        let number = cardParams.number!
        let expYear = cardParams.expYear!
        let expMonth = cardParams.expMonth!
        let cvc = cardParams.cvc!
        
        let card = CardPaymentDTO(
            number: number,
            monthExpiration: Int(truncating: expMonth),
            yearExpiration: Int(truncating: expYear),
            cvc: cvc,
            name: nameTextInput.value
        )
        
        service.createCard(card: card) { [weak self] (result) in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let stripeCard):
                strongSelf.linkCardToUser(stripeCard: stripeCard) {
                    switch $0 {
                    case .success(_):
                        CardRepository.shared.synchronizeCards()
                        completion(.success(NSNull()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error as NSError):
                completion(.failure(error))
            }
        }
    }
    
    func linkCardToUser(stripeCard: StripeCard, completion: @escaping (Result<NSNull, Error>) -> Void) -> Void {
        service.linkCard(card: stripeCard, completion: completion)
    }
}
