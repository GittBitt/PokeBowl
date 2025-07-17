//
//  PokemonDetailView.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 4/9/25.
//

import SwiftUI
import Combine
import Foundation

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @State private var speciesDescription: String = ""
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Pokémon image
                if let imageUrlString = pokemon.sprites.frontDefault,
                   let imageUrl = URL(string: imageUrlString) {
                    AsyncImage(url: imageUrl) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                        } else {
                            ProgressView()
                                .frame(height: 200)
                        }
                    }
                }
                // Pokémon name and ID
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                Text("ID: \(pokemon.id)")
                    .font(.title2)
                
                // Basic info section
                HStack(spacing: 20) {
                    VStack {
                        Text("Base Exp")
                        Text("\(pokemon.baseExperience)")
                            .bold()
                    }
                    VStack {
                        Text("Height")
                        Text("\(pokemon.height)")
                            .bold()
                    }
                    VStack {
                        Text("Weight")
                        Text("\(pokemon.weight)")
                            .bold()
                    }
                }
                Divider()
                
                // Description
                if !speciesDescription.isEmpty {
                    Text(speciesDescription)
                        .padding()
                }
                
                Divider()
                // Types info
                VStack(alignment: .leading) {
                    Text("Types:")
                        .font(.headline)
                    HStack {
                        ForEach(pokemon.types, id: \.slot) { typeEntry in
                            Text(typeEntry.type.name.capitalized)
                                .padding(5)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                        }
                    }
                }
                Divider()
                // Abilities info
                VStack(alignment: .leading, spacing: 10) {
                    Text("Abilities:")
                        .font(.headline)
                    ForEach(pokemon.abilities, id: \.slot) { ability in
                        Text(ability.ability.name.capitalized)
                    }
                }
                Divider()
                // Stats info
                VStack(alignment: .center, spacing: 10) {
                    Text("Stats:")
                        .font(.headline)
                    ForEach(pokemon.stats, id: \.stat.name) { stat in
                        HStack {
                            Text(stat.stat.name.capitalized)
                            Spacer()
                            Text("\(stat.baseStat)").bold()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle(pokemon.name.capitalized)
        .toolbar {
            Button {
                favoritesManager.toggleFavorite(pokemon)
            } label: {
                Image(systemName: favoritesManager.isFavorite(pokemon) ? "star.fill" : "star")
                    .foregroundColor(favoritesManager.isFavorite(pokemon) ? .yellow : .gray)
            }
        }
        .onAppear {
            fetchSpeciesDetails()
        }
    }
    
    private func fetchSpeciesDetails() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.id)/") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let species = try JSONDecoder().decode(PokemonSpeciesResponse.self, from: data)
                if let entry = species.flavorTextEntries.first(where: { $0.language.name == "en" }) {
                    DispatchQueue.main.async {
                        // Replace newlines with spaces for a cleaner display.
                        self.speciesDescription = entry.flavorText.replacingOccurrences(of: "\n", with: " ")
                    }
                }
            } catch {
                print("Error fetching species details: \(error)")
            }
        }.resume()
    }
}
