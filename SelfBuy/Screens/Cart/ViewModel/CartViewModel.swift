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
    var repository: CartItemRepository { get }
    
    var bag : DisposeBag { get }
    
    func getItem(index: IndexPath) -> CartCellViewModel
}

final class CartViewModel: CartViewModelling {
    let repository: CartItemRepository
    let bag = DisposeBag()

    var numberOfSection: Int = 1
    var numberOfItems: Int {
        return repository.getProducts().count
    }
    
    init() {
        repository = CartItemRepository.shared
    }
    
    func getItem(index: IndexPath) -> CartCellViewModel {
        let cartItem = repository.getProducts()[index.row]
        return CartCellViewModel(cartItem: cartItem)
    }
    
}
