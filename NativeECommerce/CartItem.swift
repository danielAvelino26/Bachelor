//
//  CartItem.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import Foundation

struct CartItem: Decodable, Identifiable {
    var id: Int { product.id }
    var product: Product
    var quantity: Int
}
