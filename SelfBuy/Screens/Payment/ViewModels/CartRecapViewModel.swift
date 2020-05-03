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
}
