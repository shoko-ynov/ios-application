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
    
    func pay(card: Card, completion: @escaping (Result<StripePaymentParams, Error>) -> Void) {
        
        let products: [PayProductDTO] = CartItemRepository.shared.getProducts().map {
            return PayProductDTO(productId: $0.product._id, quantity: $0.quantity)
        }
        let body = PayDTO(products: products, cardId: card._id)
        
        return Request()
            .setPath("/stripe/pay")
            .setMethod(.POST)
            .setBody(body)
            .sendWithDecode(StripePaymentParams.self, completion: completion)
    }
    
    func getStripePayementIntent(_ payment: StripePaymentParams, completion: @escaping (Result<StripePaymentIntent, Error>) -> Void) {
        let params = "client_secret=\(payment.clientSecret)"
        
        return StripeRequest(url: "https://api.stripe.com/v1/payment_intents/\(payment.paymentIntentId)?\(params)")
            .setMethod(.GET)
            .send(StripePaymentIntent.self, completion: completion)
    }
    
}
