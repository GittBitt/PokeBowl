//
//  FavoritesManager.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 4/9/25.
//

import Foundation
import Combine
import SwiftUI

class FavoritesManager: ObservableObject {
    @Published var favorites: [Pokemon] = []
    private var favoriteIDs: Set<Int> = []

    func isFavorite(_ pokemon: Pokemon) -> Bool {
        favoriteIDs.contains(pokemon.id)
    }

    func toggleFavorite(_ pokemon: Pokemon) {
        if isFavorite(pokemon) {
            favorites.removeAll { $0.id == pokemon.id }
            favoriteIDs.remove(pokemon.id)
        } else {
            favorites.append(pokemon)
            favoriteIDs.insert(pokemon.id)
        }
    }
}
