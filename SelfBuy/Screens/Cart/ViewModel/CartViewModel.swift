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
    var itemsViewModels: [CartCellViewModel] { get }
    // La, il manque des trucs... mais je les est pas comprises 😭
    
    func addItem()
    func getItem(index: IndexPath) -> CartCellViewModel
    func fetchOrders()
}

final class CartViewModel: CartViewModelling {
    
    func fetchOrders() {
        //self.cellViewModels.append(contentsOf: <#T##Sequence#>)
    }
    
    var itemsViewModels: [CartCellViewModel] = []
    var numberOfSection: Int = 1
    
    var numberOfItems: Int {
        return self.itemsViewModels.count
    }
    
    init() {
        let product = Product(_id: "5dda933ee0d25a0017b59900", name: "Sachet de Truffes au chocolat", category: "Sachet", price: 29.0, description: "Test de tablette", images: ["http://dev.maxencemottard.com/selfbuy/sachet_truffe_chocolat.png"])
        let item = CartItem(_id: "189U3H1B", cartId: "10K213K1", product: product, quantity: 3)
        
        self.itemsViewModels.append(CartCellViewModel(cartItem: item))
        self.itemsViewModels.append(CartCellViewModel(cartItem: item))
    }
    
    func addItem() {
        
    }
    
    func getItem(index: IndexPath) -> CartCellViewModel {
        return self.itemsViewModels[index.row]
    }
    
}
