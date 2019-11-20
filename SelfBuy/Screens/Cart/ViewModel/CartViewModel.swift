//
//  CartViewModel.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

protocol CartViewModelling {
    var numberOfSection: Int { get }
    var numberOfItems: Int { get }
    var itemsViewModels: [CartItemViewModel] { get }
    // La, il manque des trucs... mais je les est pas comprises 😭
    
    func addItem()
    func getItem(index: Int) -> CartItemViewModel
    func fetchOrders()
}

final class CartViewModel: CartViewModelling {
    
    func fetchOrders() {
        //self.cellViewModels.append(contentsOf: <#T##Sequence#>)
    }
    
    var itemsViewModels: [CartItemViewModel] = []
    var numberOfSection: Int = 1
    
    var numberOfItems: Int {
        return self.itemsViewModels.count
    }
    
    init() {
        let product = Product(_id: "azçà", name: "Test de produit", price: 3.0, description: "Hola la famille", images: [])
        let item = CartItem(_id: "189U3H1B", cartId: "10K213K1", product: product, quantity: 3)
        
        self.itemsViewModels.append(CartItemViewModel(cartItem: item))
        self.itemsViewModels.append(CartItemViewModel(cartItem: item))
    }
    
    func addItem() {
        
    }
    
    func getItem(index: Int) -> CartItemViewModel {
        return self.itemsViewModels[index]
    }
    
}
