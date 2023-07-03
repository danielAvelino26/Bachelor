//
//  ContentView.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cart: Cart
    @StateObject var request = APIRequest()
    @State private var searchText = ""
    @State var selection: Int = 0

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return request.results
        } else {
            return request.results.filter { $0.title.contains(searchText) }
        }
    }

    var body: some View {
        if let error = request.errorMessage {
            // Afficher error message
            Text(error)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        } else {
            TabView(selection: $selection) {
                VStack {
                    Search(searchText: $searchText)
                    List(filteredProducts) { product in
                        CardProduct(product: product)
                    }
                }
                .tabItem {
                    Label("Accueil", systemImage: "house")
                }
                .tag(0)
                
                CartView()
                    .tabItem {
                        Label("Panier", systemImage: "cart")
                    }
                    .tag(1)
            }
            .onAppear() {
                request.callAPI()
            }
        }
    }
}

struct Search: View {
    @Binding var searchText: String

    var body: some View {
        TextField("Recherche...", text: $searchText)
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
