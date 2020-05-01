//
//  OrderShippingViewModel.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 01/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//


import RxSwift
import Foundation

protocol OrderShippingViewModelling {
    var bag: DisposeBag { get }
    
    var firstName: BehaviorSubject<String> { get }
    var lastName: BehaviorSubject<String> { get }
    var address: BehaviorSubject<String> { get }
    var postalCode: BehaviorSubject<String> { get }
    var city: BehaviorSubject<String> { get }
    
    func getBehaviorSubjectValue(_ subject: BehaviorSubject<String>) -> String
}

final class OrderShippingViewModel: OrderShippingViewModelling {
    var firstName: BehaviorSubject<String>
    
    var lastName: BehaviorSubject<String>
    
    var address: BehaviorSubject<String>
    
    var postalCode: BehaviorSubject<String>
    
    var city: BehaviorSubject<String>
    
    var bag: DisposeBag
    
    init() {
        bag = DisposeBag()
        let user = UserRepository.shared.getUser()
        firstName = BehaviorSubject(value: user?.firstName ?? "")
        lastName = BehaviorSubject(value: user?.lastName ?? "")
        address = BehaviorSubject(value: user?.address ?? "")
        postalCode = BehaviorSubject(value: (user?.postalCode)! as String)
        city = BehaviorSubject(value: user?.city ?? "")
    }
    
    func getBehaviorSubjectValue(_ subject: BehaviorSubject<String>) -> String {
        do {
            return try subject.value()
        } catch {
            return ""
        }
    }
}

