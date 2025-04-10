//
//  BerryDetailView.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 4/9/25.
//

import SwiftUI
import Combine
import Foundation

struct BerryDetailView: View {
    let berry: BerryResponse

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // Display the berry image at the top.
                AsyncImage(url: berry.imageURL) { phase in
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
        }
        .navigationTitle("Berry Details")
    }
}
