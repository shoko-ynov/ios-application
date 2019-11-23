//
//  HomeViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 07/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation

protocol HomeViewModelling: class {
    var numberOfSection: Int { get }
    var numberOfItems: Int { get }
    var productViewModels: [ProductCellViewModelling] { get }
    var service: ProductApiService { get }
    func getItem(index: IndexPath) -> ProductCellViewModelling
    func fetchData()
}

class HomeViewModel: HomeViewModelling {
    
    init() {
        
    }
    
    let service: ProductApiService = ProductApiService()
    var numberOfSection: Int = 0
    
    var numberOfItems: Int {
        return self.productViewModels.count
    }
    
    var productViewModels: [ProductCellViewModelling] = []
    
    func getItem(index: IndexPath) -> ProductCellViewModelling {
        return self.productViewModels[index.row]
    }
    
    func fetchData() {
        service.getAllProducts { result in
            switch result {
            case .success(let products):
                for product in products {
                    self.productViewModels.append(ProductCellViewModel(product: product))
                }
            case .failure(let error as NSError):
                print(error)
            }
        }
    }
    
}
