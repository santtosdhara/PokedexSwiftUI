//
//  TypeChip.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/30/25.
//

import SwiftUI

public struct TypeChip: View {
    public let type: String
    public init(type: String) { self.type = type }
    
    public var body: some View {
        Text(type.capitalized)
            .font(.system(.caption, design: .rounded).weight(.semibold))
            .padding(.horizontal, PKMDesign.Spacing.sm)
            .padding(.vertical, PKMDesign.Spacing.xs)
            .background(Color.white.opacity(0.18))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: PKMDesign.Radius.sm, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: PKMDesign.Radius.sm)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
            .accessibilityLabel("Type: \(type)")
    }
}

//#Preview {
//    TypeChip(type: "Test")
//}
