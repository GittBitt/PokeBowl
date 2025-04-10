//
//  ContentView.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 10/28/24.
//

import SwiftUI
import Combine
import Foundation

struct ContentView: View {
    var body: some View {
        TabView {
            PokemonListView()
                .tabItem {
                    Label("Pokemon", systemImage: "list.bullet")
                }
            BerryListView()
                .tabItem {
                    Label("Berries", systemImage: "leaf")
                }
            FavoritesListView()
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}
