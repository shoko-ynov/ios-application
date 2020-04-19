//
//  CartItemRepository.swift
//  SelfBuy
//
//  Created by Maxence Mottard on 18/04/2020.
//  Copyright © 2020 MaxenceMottard. All rights reserved.
//

import Foundation
import RxSwift

final class CartItemRepository {
    
    static let shared = CartItemRepository()
    
    var products: [CartItem] = []
    var productsPublishSubject: PublishSubject<[CartItem]> = PublishSubject()
    
    init() {
        productsPublishSubject.onNext(products)
    }
    
    func addProductToCart(product: Product, quantity: Int) {
        let cartItem = CartItem(product: product, quantity: quantity)
        products.append(cartItem)
        productsPublishSubject.onNext(products)
    }
    
    func modifyQuantityForProduct(product: Product, quantity: Int) {
        let indexOfProduct = products.firstIndex { (cartItem: CartItem) -> Bool in
            return cartItem.product._id == product._id
        }
        
        guard let index = indexOfProduct else {
            return
        }
        
        products[index].quantity = quantity
        productsPublishSubject.onNext(products)
    }
    
    func deleteProduct(product: Product) {
        let index = products.firstIndex(where: { cartItem in
            return cartItem.product._id == product._id
        })
        
        guard let strongIndex = index else { return }
        products.remove(at: strongIndex)
        
        productsPublishSubject.onNext(products)
    }
}
