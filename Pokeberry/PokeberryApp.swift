//
//  PokeberryApp.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 10/28/24.
//

import SwiftUI

@main
struct PokeberryApp: App {
    @StateObject private var favoritesManager = FavoritesManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoritesManager)
        }
    }
}
