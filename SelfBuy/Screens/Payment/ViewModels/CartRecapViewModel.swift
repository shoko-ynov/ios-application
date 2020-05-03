//
//  CartRecapViewModel.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 03/05/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol CartRecapViewModelling {
    var bag: DisposeBag { get }
    var repository: CartItemRepository { get }
    var numberOfItems: Int { get }
    
    func getTotalPrice() -> String
}

final class CartRecapViewModel: CartRecapViewModelling {
    let bag: DisposeBag
    let repository: CartItemRepository
    var numberOfItems: Int {
        return repository.getProducts().count
    }
    
    init() {
        bag = DisposeBag()
        repository = CartItemRepository.shared
    }
    
    func getTotalPrice() -> String {
        var price: Float = 0.0
        
        for cartItem in repository.getProducts() {
            price += cartItem.product.price * Float(cartItem.quantity)
        }
        
        return String(format: "%.2f", price)
    }

}
