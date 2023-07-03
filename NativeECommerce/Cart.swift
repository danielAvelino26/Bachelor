//
//  Cart.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import Foundation


class Cart: ObservableObject {
    @Published private(set) var products: [CartItem] = []
    
    func addToCart(product: Product) {
        if let index: Int = products.firstIndex(where: {$0.product.id == product.id}) {
            products[index].quantity += 1
        } else {
            products.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeToCart(product: Product) {
        if let index: Int = products.firstIndex(where: {$0.product.id == product.id}) {
            if (products[index].quantity == 1) {
                products.remove(at: index)
            } else {
                products[index].quantity -= 1
            }
        } else {
            print("Ce produit n'existe pas dans le panier")
        }
    }
    
    func getTotalAmount() -> Double {
        var total: Double = 0
        products.forEach { product in
            total += product.product.price * Double(product.quantity)
        }
        
        return round(total * 100) / 100.0
    }
}
