//
//  PaymentApiService.swift
//  SelfBuy
//
//  Created by Léo GIGT on 25/03/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

final class PaymentApiService {
    let decoder = JSONDecoder()
    
    func createCard(card: CardPaymentDTO, completionHandler: @escaping (Result<StripeCard, Error>) -> Void) {
        let request = StripeRequest(url: "https://api.stripe.com/v1/tokens")
        
        var body = "card[number]=\(card.number)";
        body += "&card[exp_month]=\(card.monthExpiration)";
        body += "&card[exp_year]=\(card.yearExpiration)";
        body += "&card[cvc]=\(card.cvc)";
        body += "&card[name]=\(card.name)";
        
        request
            .setMethod(.POST)
            .setBody(body)
            .send(StripeCard.self, completion: completionHandler)
    }
    
    func linkCard(card: StripeCard, completion: @escaping (Result<NSNull, Error>) -> Void) {
        let request = Request()
        
        let body = LinkCardDTO(stripeToken: card.id)
        
        request
            .setPath("/cards")
            .setMethod(.POST)
            .setBody(body)
            .send(completion: completion)
    }
    
    func removeCard(card: Card, completion: @escaping (Result<NSNull, Error>) -> Void) {
        Request()
            .setPath("/cards/\(card._id)")
            .setMethod(.DELETE)
            .send(completion: completion)
    }
}
