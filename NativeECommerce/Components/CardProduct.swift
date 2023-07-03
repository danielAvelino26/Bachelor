//
//  CardProduct.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import SwiftUI

struct CardProduct: View {
    @EnvironmentObject var cart: Cart
    
    var product: Product
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            } placeholder: {
                Color.gray
            }
            .frame(width: 120, height: 120)
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.top, 16)
                Text(String(format: "%.2f.-", product.price))
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.top, 8)
                
                Spacer()
                
                Button(action: {
                    cart.addToCart(product: product)
                }) {
                    Text("Ajouter au panier")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }.buttonStyle(BorderlessButtonStyle())
                
                Spacer().frame(height: 16)
            }
            .padding(.leading, 16)
        }
        .padding(.horizontal, 8)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(.vertical, 4)
    }
}
