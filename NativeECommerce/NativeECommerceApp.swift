//
//  NativeECommerceApp.swift
//  NativeECommerce
//
//  Created by Daniel Avelino Lopes on 03.07.23.
//

import SwiftUI

@main
struct NativeECommerceApp: App {
    @StateObject private var cart = Cart()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cart)
        }
    }
}
