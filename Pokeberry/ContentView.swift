//
//  ContentView.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 10/28/24.
//

import SwiftUI

struct ContentView: View {
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
                            Text(berry.name.capitalized)
                                .font(.headline)
                            Spacer()
                            Text("ID: \(berry.id)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
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

struct BerryDetailView: View {
    let berry: BerryResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(berry.name.capitalized)
                .font(.largeTitle)
                .bold()
            Text("Firmness: \(berry.firmness.name.capitalized)")
            Text("Growth Time: \(berry.growthTime) minutes")
            Text("Max Harvest: \(berry.maxHarvest)")
            Text("Natural Gift Power: \(berry.naturalGiftPower)")
            Text("Size: \(berry.size)")
            Text("Smoothness: \(berry.smoothness)")
            Text("Soil Dryness: \(berry.soilDryness)")

            Text("Flavors:")
                .font(.headline)
            ForEach(berry.flavors, id: \.flavor.name) { flavor in
                Text("- \(flavor.flavor.name.capitalized): \(flavor.potency)")
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Berry Details")
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search berries...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.white))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8)
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
    }
}

#Preview {
    ContentView()
}
