//
//  ContentView.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/27/25.
//

import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Pokemon...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundStyle(Color.red)
                } else {
                    List(viewModel.pokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            Text(pokemon.name.capitalized)
                        }
                    }
                }
            }
            .navigationTitle("Pokedex")
        }
        .task {
            await viewModel.fetchPokemon()
        }
    }
}

#Preview {
    PokemonListView()
}
