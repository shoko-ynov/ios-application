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
    var cartItemPublishSubject: PublishSubject<[CartItem]> { get }
    
    var bag : DisposeBag { get }
    
    func getItem(index: IndexPath) -> CartCellViewModel
}

final class CartViewModel: CartViewModelling {
    var bag = DisposeBag()

    var numberOfSection: Int = 1
    var numberOfItems: Int {
        return CartItemRepository.shared.getProducts().count
    }
    
    var cartItemPublishSubject: PublishSubject<[CartItem]>
    
    init() {
        cartItemPublishSubject = PublishSubject()
        cartItemPublishSubject.onNext(CartItemRepository.shared.getProducts())
        
        CartItemRepository.shared.productsSubject
            .subscribe(onNext: { [weak self] products in
                guard let strongSelf = self else { return }
                strongSelf.cartItemPublishSubject.onNext(CartItemRepository.shared.getProducts())
            }).disposed(by: bag)
    }
    
    func getItem(index: IndexPath) -> CartCellViewModel {
        let cartItem = CartItemRepository.shared.getProducts()[index.row]
        return CartCellViewModel(cartItem: cartItem)
    }
    
}
