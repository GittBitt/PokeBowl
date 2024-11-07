//
//  Berry.swift
//  PokeBerry
//
//  Created by Nghi Huynh on 10/28/24.
//

import Foundation

// Models
struct BerryResponse: Codable, Identifiable {
    var id: Int // This property already exists
    var name: String
    var firmness: Firmness
    var flavors: [Flavor]
    var growthTime: Int
    var maxHarvest: Int
    var naturalGiftPower: Int
    var naturalGiftType: Type
    var size: Int
    var smoothness: Int
    var soilDryness: Int

    // Custom CodingKeys to match JSON keys
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

struct Type: Codable {
    var name: String
    var url: String
}
