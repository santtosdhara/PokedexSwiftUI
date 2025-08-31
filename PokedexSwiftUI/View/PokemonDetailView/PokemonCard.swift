//
//  PokemonCard.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/30/25.
//

import SwiftUI

struct PokemonCard: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .frame(width: 350, height: 600)
                    .cornerRadius(30)
            }
            .navigationTitle("Pokemon Card")
        }
    }
}



#Preview {
    PokemonCard()
}
