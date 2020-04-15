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
    
    func createCard(card: CardPaymentDTO,completionHandler: @escaping (Result<CardPayment, Error>) -> Void) {
        let request = StripeRequest(url: "https://api.stripe.com/v1/tokens")
        
        var body = "card[number]=\(card.number)";
        body += "&card[exp_month]=\(card.monthExpiration)";
        body += "&card[exp_year]=\(card.yearExpiration)";
        body += "&card[cvc]=\(card.cvc)";
        body += "&card[name]=\(card.name)";
        
        request
            .setMethod(.POST)
            .setBody(body)
            .send(CardPayment.self) {
                switch $0 {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
        }
    }
}
