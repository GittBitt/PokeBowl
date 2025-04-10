//
//  Berry.swift
//  PokeBerry
//
//  Created by Nghi Huynh on 10/28/24.
//

import Foundation

struct BerryResponse: Codable, Identifiable {
    var id: Int
    var name: String
    var firmness: Firmness
    var flavors: [Flavor]
    var growthTime: Int
    var maxHarvest: Int
    var naturalGiftPower: Int
    var naturalGiftType: BerryType
    var size: Int
    var smoothness: Int
    var soilDryness: Int

    // Match JSON keys via custom CodingKeys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firmness
        case flavors
        case growthTime = "growth_time"
        case maxHarvest = "max_harvest"
        case naturalGiftPower = "natural_gift_power"
        case naturalGiftType = "natural_gift_type"
        case size
        case smoothness
        case soilDryness = "soil_dryness"
    }
    
    // Computed property to provide an image URL for the berry.
    // We assume the image URL follows the pattern:
    // https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/{berry-name}-berry.png
    var imageURL: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/\(name.lowercased())-berry.png")
    }
}

struct Firmness: Codable {
    var name: String
    var url: String
}

struct Flavor: Codable {
    var flavor: FlavorDetail
    var potency: Int
}

struct FlavorDetail: Codable {
    var name: String
    var url: String
}

// Renamed from "Type" to avoid conflict with Swift’s keyword.
struct BerryType: Codable {
    var name: String
    var url: String
}
