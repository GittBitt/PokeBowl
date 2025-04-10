//
//  Pokemon.swift
//  Pokeberry
//
//  Created by Nghi Huynh on 4/9/25.
//

struct PokemonResponse: Codable, Identifiable {
    var id: Int
    var name: String
    var sprites: Sprites

    struct Sprites: Codable {
        var frontDefault: String?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}
