//
//  OrdersViewModel.swift
//  SelfBuy
//
//  Created by Zakarya TOLBA on 10/01/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation

protocol OrdersViewModelling {
    var numberOfSection: Int { get }
    var numberOfItems: Int { get }
    var itemsViewModels: [OrdersCellViewModel] { get }
    
    func addItem()
    func getItem(index: IndexPath) -> OrdersCellViewModel
    func fetchOrders()
}

//final class OrdersViewModel: OrdersViewModelling {
//    
//    func fetchOrders() {
//        //self.cellViewModels.append(contentsOf: <#T##Sequence#>)
//    }
//    
//    var itemsViewModels: [OrdersViewModel] = []
//    var numberOfSection: Int = 1
//    
//    var numberOfItems: Int {
//        return self.itemsViewModels.count
//    }
//    
//    init() {
//        let product = Product(_id: "5dda933ee0d25a0017b59900", name: "Sachet de Truffes au chocolat", category: "Sachet", price: 29.0, description: "Test de tablette", images: ["http://dev.maxencemottard.com/selfbuy/sachet_truffe_chocolat.png"])
//        let item = CartItem(_id: "189U3H1B", cartId: "10K213K1", product: product, quantity: 3)
//        
//        self.itemsViewModels.append(OrdersCellViewModel(cartItem: item))
//        self.itemsViewModels.append(OrdersCellViewModel(cartItem: item))
//    }
//    
//    func addItem() {
//        
//    }
//    
//    func getItem(index: IndexPath) -> OrdersCellViewModel {
//        return self.itemsViewModels[index.row]
//    }
//    
//}
