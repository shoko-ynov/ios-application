//
//  CartCellViewModel.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol CartCellViewModelling {
    var cartItem: CartItem { get }
    var isMove: PublishSubject<Bool> { get }
    var bag: DisposeBag { get }
    
    func deleteProductFromCart() -> Void
}

final class CartCellViewModel : CartCellViewModelling {
    let cartItem: CartItem
    let isMove: PublishSubject<Bool>
    let bag: DisposeBag
    
    init(cartItem: CartItem) {
        self.cartItem = cartItem
        self.bag = DisposeBag()
        self.isMove = PublishSubject()
        
        self.isMove.onNext(false)
    }
    
    func deleteProductFromCart() {
        CartItemRepository.shared.deleteProduct(product: cartItem.product)
    }
}
