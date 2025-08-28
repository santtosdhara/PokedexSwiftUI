//
//  PokemonDetailView.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/28/25.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: PokemonListItem
    
    var body: some View {
        VStack {
            Text(pokemon.name.capitalized)
                .font(.largeTitle)
            Text(pokemon.url) // you could parse the ID here for fetching details
        }
        .padding()
    }
}

#Preview {
    PokemonDetailView(pokemon: PokemonListItem(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"))
}
