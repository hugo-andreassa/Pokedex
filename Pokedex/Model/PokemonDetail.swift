//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Hugo Andreassa Amaral (P) on 11/07/22.
//

import Foundation
import ObjectMapper

struct PokemonDetail: Mappable {
    var sprite: Sprite?
    var types: [Types]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        sprite <- map["sprites"]
        types <- map["types"]
    }
}

struct Sprite: Mappable {
    var frontSpritUrl: String?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        frontSpritUrl <- map["front_default"]
    }
}

struct Types: Mappable {
    var nameType: String?
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        nameType <- map["type.name"]
    }
}
