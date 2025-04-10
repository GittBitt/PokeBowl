//
//  BerryListView.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 4/9/25.
//

import SwiftUI
import Combine
import Foundation

struct BerryListView: View {
    @StateObject private var viewModel = BerryViewModel()
    @State private var searchText = ""

    var filteredBerries: [BerryResponse] {
        if searchText.isEmpty {
            return viewModel.berries
        } else {
            return viewModel.berries.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                List(filteredBerries) { berry in
                    NavigationLink(destination: BerryDetailView(berry: berry)) {
                        HStack {
                            // Show berry image using AsyncImage:
                            AsyncImage(url: berry.imageURL) { phase in
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
                            VStack(alignment: .leading) {
                                Text(berry.name.capitalized)
                                    .font(.headline)
                                Text("ID: \(berry.id)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationTitle("PokeBerries")
            }
        }
        .onAppear {
            viewModel.fetchBerries()
        }
    }
}
