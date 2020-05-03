//
//  OrderConfirmationViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 01/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import RxSwift
import Foundation
import UIKit

protocol OrderConfirmationViewModelling {
    var bag: DisposeBag { get }
    var service: PaymentApiService { get }
    var selectedCard: Card? { get }
    var stripePayment: BehaviorSubject<StripePaymentParams?> { get }
    var paymentIntent: PublishSubject<StripePaymentIntent> { get }
    
    func payOrder() -> Void
    func setSelectedCard(_ card: Card) -> Void
    func checkStripePaymentIntent() -> Void
}

final class OrderConfirmationViewModel: OrderConfirmationViewModelling {
    var selectedCard: Card?
    let bag: DisposeBag
    let service: PaymentApiService
    let stripePayment: BehaviorSubject<StripePaymentParams?>
    var paymentIntent: PublishSubject<StripePaymentIntent>
    
    init() {
        bag = DisposeBag()
        service = PaymentApiService()
        stripePayment = BehaviorSubject(value: nil)
        paymentIntent = PublishSubject()
    }
    
    func payOrder() {
        guard let card = selectedCard else { return }
        
        service.pay(card: card) { [weak self] in
            guard let strongSelf = self else { return }
            CartItemRepository.shared.clearCart()
            
            switch $0 {
            case .success(let payment):
                strongSelf.stripePayment.onNext(payment)
                strongSelf.checkStripePaymentIntent()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkStripePaymentIntent() {
        do {
            guard let payementDTO = try stripePayment.value() else { return }
            print(payementDTO)
            
            service.getStripePayementIntent(payementDTO) { [weak self] in
                guard let strongSelf = self else { return }
                switch $0 {
                case .success(let paymentIT):
                    strongSelf.paymentIntent.onNext(paymentIT)
                case .failure(let error):
                    print(error)
                }
            }
        } catch {
            print("error")
        }
    }
    
    func setSelectedCard(_ card: Card) {
        selectedCard = card
    }
}
