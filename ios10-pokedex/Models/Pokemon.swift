//
//  Pokemon.swift
//  ios10-pokedex
//
//  Created by Austin Potts on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

//The Model that will Parse the JSON
struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: Sprites
    let types: [Type]
}

//Struct needed to 'Un-Nest Pokeom Image(sprite)
struct Sprites: Decodable {
    let frontDefault: URL
    
}

//Two Structs needed to 'Un-Nest' the type of pokemon
struct Type: Decodable, Equatable {
    let type: Species
}

struct Species: Equatable, Codable {
    let name: String
}
