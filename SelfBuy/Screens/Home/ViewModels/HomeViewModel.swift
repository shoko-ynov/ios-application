//
//  HomeViewModel.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 07/11/2019.
//  Copyright © 2019 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewModelling: class {
    var numberOfSection: Int { get }
    var numberOfItems: Int { get }
    var productViewModels: [ProductCellViewModelling] { get }
    var service: ProductApiService { get }
    func getItem(index: IndexPath) -> ProductCellViewModelling
    func fetchData()
    var bag: DisposeBag { get }
    var shouldReloadData: PublishSubject<Void> { get }
}

final class HomeViewModel: HomeViewModelling {
    var bag = DisposeBag()
    var shouldReloadData: PublishSubject<Void> = PublishSubject<Void>()
    
    init() {
        
    }
    
    let service: ProductApiService = ProductApiService()
    var numberOfSection: Int = 0
    
    var numberOfItems: Int {
        return self.productViewModels.count
    }
    
    var productViewModels = [ProductCellViewModelling]() {
        didSet {
            self.shouldReloadData.onNext(())
        }
    }
    
    func getItem(index: IndexPath) -> ProductCellViewModelling {
        return self.productViewModels[index.row]
    }
    
    func fetchData() {
        service.getAllProducts { result in
            switch result {
            case .success(let products):
                self.productViewModels = []
                for product in products {
                    self.productViewModels.append(ProductCellViewModel(product: product))
                }
            case .failure(let error as NSError):
                print(error)
                self.productViewModels = []
            }
        }
    }
    
}
