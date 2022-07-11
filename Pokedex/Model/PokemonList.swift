//
//  PokemonItem.swift
//  Pokedex
//
//  Created by Hugo Andreassa Amaral (P) on 08/07/22.
//

import Foundation
import ObjectMapper

struct PokemonList: Mappable {
    var nextPage: String?
    var previousPage: String?
    var pokemons: [PokemonItem]?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        nextPage <- map["next"]
        previousPage <- map["previous"]
        pokemons <- map["results"]
    }
}

struct PokemonItem: Mappable {
    var name: String?
    var url: String?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
    }
}
