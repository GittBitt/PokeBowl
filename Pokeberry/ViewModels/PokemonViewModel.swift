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
    @Published var pokemon: [PokemonResponse] = []

    func fetchPokemon() {
        let pokemonCount = 10 // Fetch Pokémon with IDs from 1 to pokemonCount
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
            print("All Pokémon data fetched.")
        }
    }

    private func fetchPokemonData(withID id: Int, completion: @escaping (PokemonResponse?) -> Void) {
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
                let pokemon = try JSONDecoder().decode(PokemonResponse.self, from: data)
                completion(pokemon)
            } catch {
                print("Error decoding Pokémon JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
