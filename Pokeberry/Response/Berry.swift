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

    enum CodingKeys: String, CodingKey {
        case id, name, firmness, flavors
        case growthTime = "growth_time"
        case maxHarvest = "max_harvest"
        case naturalGiftPower = "natural_gift_power"
        case naturalGiftType = "natural_gift_type"
        case size, smoothness
        case soilDryness = "soil_dryness"
    }
    
    // Computed property to build a berry image URL from its name.
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

struct BerryType: Codable {
    var name: String
    var url: String
}
