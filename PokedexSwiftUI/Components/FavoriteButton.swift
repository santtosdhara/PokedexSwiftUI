//
//  FavoriteButton.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/30/25.
//

import SwiftUI

public struct FavoriteButton: View {
    
    public var isOn: Bool
    public var action: () -> Void
    
    public init(isOn: Bool, action: @escaping () -> Void) {
        self.isOn = isOn
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: isOn ? "heart.fill" : "heart")
                .font(.title3)
                .foregroundStyle(.white)
                .padding(PKMDesign.Spacing.sm)
                .background(.white.opacity(0.12), in: Circle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isOn ? "Favorited" : "Not favorited")
        
    }
}

//#Preview {
//    FavoriteButton(isOn: false, action: )
//}
