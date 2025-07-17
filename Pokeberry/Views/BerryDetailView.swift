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
            VStack { // The main container VStack
                // Berry image
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
                
                // Change this VStack's alignment to .center
                VStack(alignment: .center, spacing: 10) {
                    Text(berry.name.capitalized)
                        .font(.largeTitle)
                        .bold()
                    
                    Divider()
                    
                    Text("Firmness: \(berry.firmness.name.capitalized)")
                    Text("Growth Time: \(berry.growthTime) minutes")
                    Text("Max Harvest: \(berry.maxHarvest)")
                    Text("Natural Gift Power: \(berry.naturalGiftPower)")
                    Text("Size: \(berry.size)")
                    Text("Smoothness: \(berry.smoothness)")
                    Text("Soil Dryness: \(berry.soilDryness)")
                    
                    Divider()
                    
                    // Flavors Section
                    Text("Flavors:")
                        .font(.headline)

                    ForEach(berry.flavors, id: \.flavor.name) { flavor in
                        HStack {
                            // The flavor name on the left
                            Text("- \(flavor.flavor.name.capitalized)")
                            
                            Spacer()
                            
                            // The flavor potency on the right, in bold
                            Text("\(flavor.potency)").bold()
                        }
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Berry Details")
    }
}
