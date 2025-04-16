//
//  PokemonListView.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 4/9/25.
//

import SwiftUI
import Combine
import Foundation

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonViewModel()
    @State private var searchText = ""

    var filteredPokemon: [Pokemon] {
        if searchText.isEmpty {
            return viewModel.pokemon
        } else {
            return viewModel.pokemon.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredPokemon) { poke in
                NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                    HStack {
                        if let imageUrlString = poke.sprites.frontDefault,
                           let imageUrl = URL(string: imageUrlString) {
                            AsyncImage(url: imageUrl) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else if phase.error != nil {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                } else {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(poke.name.capitalized)
                                .font(.headline)
                            Text("ID: \(poke.id)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Pokedex")
            .searchable(text: $searchText)
        }
        .onAppear {
            viewModel.fetchPokemon()
        }
    }
}
