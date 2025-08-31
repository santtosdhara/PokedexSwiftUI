//
//  LabeledValue.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/30/25.
//

import SwiftUI

public struct LabeledValue: View {
    public let label: String
    public let value: String
    
    public init(label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    public var body: some View {
        HStack(spacing: PKMDesign.Spacing.sm) {
            Text(label)
                .font(.system(.caption, design: .rounded))
                .foregroundStyle(.white.opacity(0.9))
            Spacer(minLength: 0)
            Text(value)
                .font(.system(.callout, design: .rounded).weight(.semibold))
                .foregroundStyle(.white)
                .padding(.horizontal, PKMDesign.Spacing.sm)
                .padding(.vertical, 4)
                .background(.white.opacity(0.15), in: Capsule())
                .accessibilityLabel("\(label) \(value)")
        }
    }
}

#Preview {
    LabeledValue(label: "Test Label", value: "Test Value")
}
