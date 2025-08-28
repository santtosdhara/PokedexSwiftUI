//
//  PokemonListViewModel.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/28/25.
//

import Foundation
import Combine

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemon: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = PokemonNetwork()
    
    func fetchPokemon() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await service.getPokemonList(limit: 20, offset: 0)
            pokemon = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

    
    
