//
//  PokemonViewModel.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 4/9/25.
//

import SwiftUI
import Combine
import Foundation

class PokemonViewModel: ObservableObject {
    @Published var pokemon: [Pokemon] = []

    func fetchPokemon() {
        // Clear the array to prevent duplicates
        self.pokemon.removeAll()
        
        let pokemonCount = 300 // Fetch Pokémon IDs 1...300
        let group = DispatchGroup()
        
        for id in 1...pokemonCount {
            group.enter()
            fetchPokemonData(withID: id) { pokemonResponse in
                if let poke = pokemonResponse {
                    DispatchQueue.main.async {
                        self.pokemon.append(poke)
                    }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.pokemon.sort { $0.id < $1.id }
            print("All Pokémon data fetched and sorted.")
        }
    }

    private func fetchPokemonData(withID id: Int, completion: @escaping (Pokemon?) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else {
            print("Invalid Pokémon URL")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching Pokémon data: \(String(describing: error))")
                completion(nil)
                return
            }
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon)
            } catch {
                print("Error decoding Pokémon JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
