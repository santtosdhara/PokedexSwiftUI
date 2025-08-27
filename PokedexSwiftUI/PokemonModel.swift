//
//  PokemonModel.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/27/25.
//

import SwiftUI


struct Pokemon: Identifiable, Decodable {
    let pokemonId = UUID()
    
    let id: Int
    let name: String
    let imageURL: String
    let type: String
    let description: String
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "imageUrl"
        case type
        case description
    }
    
}
