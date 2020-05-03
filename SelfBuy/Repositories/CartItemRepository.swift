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
    
    var productsSubject: BehaviorSubject<[CartItem]> = BehaviorSubject(value: [])
    
    func getProducts() -> [CartItem] {
        do {
            return try productsSubject.value()
        } catch {
            return []
        }
    }
    
    func addProductToCart(product: Product, quantity: Int) {
        var products = getProducts()

        let isProductInCard = isProductInCart(product: product)
        
        if(!isProductInCard){
            let cartItem = CartItem(product: product, quantity: quantity)
            products.append(cartItem)
            productsSubject.onNext(products)
        } else {
            addQuantityToProduct(product: product, quantity: quantity)
        }
    }
    
    func isProductInCart(product: Product) -> Bool {
        let products = getProducts()
        
        let indexOfProduct = products.firstIndex { (cartItem: CartItem) -> Bool in
            return cartItem.product._id == product._id
        }
        
        if (indexOfProduct != nil) {
            return true
        }
        
        return false
    }
    
    func addQuantityToProduct(product: Product, quantity: Int){
        var products = getProducts()
        
        let indexOfProduct = products.firstIndex { (cartItem: CartItem) -> Bool in
            return cartItem.product._id == product._id
        }
        
        guard let index = indexOfProduct else {
            return
        }
        
        products[index].quantity = products[index].quantity + quantity
        productsSubject.onNext(products)
    }
    
    func getCartItem(product: Product) -> CartItem? {
        let indexOfProduct = products.firstIndex { (cartItem: CartItem) -> Bool in
            return cartItem.product._id == product._id
        }
        
        guard let index = indexOfProduct else {
            return nil
        }
        
        return products[index]
    }
    
    func modifyQuantityForProduct(product: Product, quantity: Int) {
        var products = getProducts()
        
        let indexOfProduct = products.firstIndex { (cartItem: CartItem) -> Bool in
            return cartItem.product._id == product._id
        }
        
        guard let index = indexOfProduct else {
            return
        }
        
        products[index].quantity = quantity
        productsSubject.onNext(products)
    }
    
    func deleteProduct(product: Product) {
        var products = getProducts()
        
        let index = products.firstIndex(where: { cartItem in
            return cartItem.product._id == product._id
        })
        
        guard let strongIndex = index else { return }
        products.remove(at: strongIndex)
        
        productsSubject.onNext(products)
    }
    
    func clearCart() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.productsSubject.onNext([])
        }
    }
}
