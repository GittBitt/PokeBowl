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
    let pokemon: PokemonResponse

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                if let imageUrlString = pokemon.sprites.frontDefault,
                   let imageUrl = URL(string: imageUrlString) {
                    AsyncImage(url: imageUrl) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } else if phase.error != nil {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(height: 200)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(height: 200)
                        .aspectRatio(contentMode: .fit)
                }
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                Text("ID: \(pokemon.id)")
                    .font(.title2)
                Spacer()
            }
            .padding()
        }
        .navigationTitle(pokemon.name.capitalized)
    }
}
