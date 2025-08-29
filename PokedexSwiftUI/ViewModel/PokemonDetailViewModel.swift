//
//  PokemonDetailViewModel.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/28/25.
//

import SwiftUI
import Foundation
import Combine

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published var detail: PokemonDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let network = PokemonAPIClient()

       func load(idOrName: String) async {
           isLoading = true
           errorMessage = nil
           do {
               detail = try await network.getPokemonDetail(idOrName)
           } catch {
               errorMessage = error.localizedDescription
           }
           isLoading = false
       }
}
