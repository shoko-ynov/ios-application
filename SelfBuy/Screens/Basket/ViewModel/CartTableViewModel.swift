//
//  CartCellViewModel.swift
//  SelfBuy
//
//  Created by Arthur on 20/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

protocol CartTableViewModelling {
    var numberOfSection: Int { get }
    var numberOfRow: Int { get }
    var cellViewModels: [CartCellViewModel] { get }
    // La, il manque des trucs... mais je les est pas comprises 😭
    
    func addItem()
    func getItem(at indexPath: IndexPath) -> CartCellViewModel
    func fetchOrders()
}

final class CartTableViewModel: CartTableViewModelling {
    
    func fetchOrders() {
        //self.cellViewModels.append(contentsOf: <#T##Sequence#>)
    }
    
    var cellViewModels: [CartCellViewModel] = []
    var numberOfSection: Int = 1
    var numberOfRow: Int = 0
    
    init() {
        
    }
    
    func addItem() {
        
    }
    
    func getItem(at indexPath: IndexPath) -> CartCellViewModel {
        return self.cellViewModels[indexPath.row]
    }
    
}
