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

class CardViewModel {
    let bag = DisposeBag()
    let service = PaymentApiService()
    
    let nameTextInput = BehaviorRelay<String>(value: "")
    
    func createCard(cardParams : STPPaymentMethodCardParams) {
        let number = cardParams.number!
        let expYear = cardParams.expYear!
        let expMonth = cardParams.expMonth!
        let cvc = cardParams.cvc!
        
        let card = CardPaymentDTO(number: number, monthExpiration: Int(expMonth), yearExpiration: Int(expYear), cvc: cvc, name: nameTextInput.value)
        service.createCard(card: card) { (result) in
            switch result {
            case .success(let stripeCard):
                print("success")
            case .failure(let error as NSError):
                print(error)
            default:
                print("default")
            }
        }
        print(card)
    }
}
