//
//  CartView.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: Cart

    var body: some View {
        VStack {
            List(cart.products) { cartItem in
                CardProductCart(product: cartItem)
            }
            Divider()
            HStack {
                Text("Total")
                Spacer()
                Text(String(cart.getTotalAmount()))
            }
            .padding()
        }
    }
}
