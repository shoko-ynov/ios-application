//
//  CartViewModel.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol CartViewModelling {
    var numberOfSection: Int { get }
    var numberOfItems: Int { get }
    
    func getItem(index: IndexPath) -> CartCellViewModel
    
    var bag : DisposeBag { get }
    
    var cartItemPublishSubject: PublishSubject<[CartItem]> { get }
}

final class CartViewModel: CartViewModelling {
    var cartItemPublishSubject: PublishSubject<[CartItem]>
    var bag = DisposeBag()

    var numberOfSection: Int = 1
    
    var numberOfItems: Int {
        return CartService.shared.products.count
    }
    
    init() {
        cartItemPublishSubject = PublishSubject()
        cartItemPublishSubject.onNext(CartService.shared.products)
    }
    
    func getItem(index: IndexPath) -> CartCellViewModel {
        let cartItem = CartService.shared.products[index.row]
        return CartCellViewModel(cartItem: cartItem)
    }
    
}
