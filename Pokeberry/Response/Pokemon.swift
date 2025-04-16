//
//  Pokemon.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 4/9/25.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    var id: Int
    var name: String
    var baseExperience: Int
    var height: Int
    var weight: Int
    var abilities: [Ability]
    var types: [PokemonTypeEntry]
    var stats: [Stat]
    var sprites: Sprites

    enum CodingKeys: String, CodingKey {
        case id, name, abilities, types, stats, sprites
        case baseExperience = "base_experience"
        case height, weight
    }
}

struct Sprites: Codable {
    var frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Ability: Codable, Identifiable {
    let id = UUID()
    var ability: AbilityDetail
    var isHidden: Bool
    var slot: Int

    enum CodingKeys: String, CodingKey {
        case ability, slot
        case isHidden = "is_hidden"
    }
}

struct AbilityDetail: Codable {
    var name: String
    var url: String
}

struct PokemonTypeEntry: Codable, Identifiable {
    let id = UUID()
    var slot: Int
    var type: TypeDetail

    struct TypeDetail: Codable {
         var name: String
         var url: String
    }
}

struct Stat: Codable, Identifiable {
    let id = UUID()
    var baseStat: Int
    var effort: Int
    var stat: StatDetail

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat", effort, stat
    }
}

struct StatDetail: Codable {
    var name: String
    var url: String
}

