//
//  PokemonDetailView.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/28/25.
//

import SwiftUI

struct PokemonDetailView: View {
    let idOrName: String
    @StateObject private var vm = PokemonDetailViewModel()
   

    var body: some View {
        var pokemonName = vm.detail?.name ?? ""
        Group {
            if vm.isLoading {
                ProgressView("Loading…")
            } else if let error = vm.errorMessage {
                Text("Error: \(error)").foregroundStyle(.red)
            } else if let p = vm.detail {
                VStack(spacing: 16) {
                    Text(p.name.capitalized)
                        .font(.largeTitle).bold()
                    Text("ID: \(p.id)")
                    Text("Height: \(p.height)")
                    Text("Weight: \(p.weight)")

                    if let urlString = p.sprites.frontDefault, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 160)
                    }
                }
                .padding()
            } else {
                Text("No data")
            }
        }
        .navigationTitle("Pokedex")
        .task {
            await vm.load(idOrName: idOrName)
        }
    }
}

#Preview {
    PokemonDetailView(idOrName: "bulbasaur")
}
