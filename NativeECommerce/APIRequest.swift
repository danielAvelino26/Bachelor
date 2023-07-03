//
//  APIRequest.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import Foundation

class APIRequest: ObservableObject {
    @Published var results: [Product] = []
    @Published var errorMessage: String? = nil

    func callAPI() {
        // Définition de l'URL de l'API en tant que chaîne de caractères
        let urlString: String = "https://fakestoreapi.com/products"
        // Essayer de convertir la chaîne de caractères en URL
        if let url: URL = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self.errorMessage = "Erreur réseau : \(error.localizedDescription)"
                    } else if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                        self.errorMessage = "Erreur serveur : \(httpResponse.statusCode)"
                    } else if let data = data {
                        do {
                            let products = try JSONDecoder().decode([Product].self, from: data)
                            self.results = products
                            self.errorMessage = nil
                        } catch {
                            self.errorMessage = "Erreur de décodage : \(error.localizedDescription)"
                        }
                    }
                    if self.errorMessage != nil {
                        self.results = []
                    }
                }
            }.resume()
        }
    }
}
