//
//  CardProductCart.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import SwiftUI

struct CardProductCart: View {
    @EnvironmentObject var cart: Cart
    var product: CartItem

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading) {
                Text(product.product.title)
                    .font(.headline)
                Spacer()
                Text("Quantité: \(product.quantity)")
                    .font(.subheadline)
                Text("Prix: \(product.product.price, specifier: "%.2f").-")
                    .font(.subheadline)
            }

            VStack {
                PlusButton(cart: cart, product: product)
                MinusButton(cart: cart, product: product)
            }
            .frame(width: 50)
        }
        .padding(5)
        .cornerRadius(10)
    }
}

struct PlusButton: View {
    @ObservedObject var cart: Cart
    var product: CartItem

    var body: some View {
        Button(action: {
            cart.addToCart(product: product.product)
        }) {
            Image(systemName: "plus")
                .foregroundColor(.white)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }.buttonStyle(BorderlessButtonStyle())
    }
}

struct MinusButton: View {
    @ObservedObject var cart: Cart
    var product: CartItem

    var body: some View {
        Button(action: {
            cart.removeToCart(product: product.product)
        }) {
            Image(systemName: "minus")
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
        }.buttonStyle(BorderlessButtonStyle())
    }
}

