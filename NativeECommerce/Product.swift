//
//  Product.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import Foundation

struct Product: Decodable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var price: Double
    var category: String
    var image: String
}
