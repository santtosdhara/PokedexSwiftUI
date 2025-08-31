//
//  StatBar.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/30/25.
//

import SwiftUI

public struct StatBar: View {
    public let title: String
    public let value: Int
    public let max: Int
    
    public init(title: String, value: Int, max: Int) {
        self.title = title
        self.value = value
        self.max = max
    }
    
    private var progress: Double { min(Double(value) / Double(max), 1.0) }
    
    public var body: some View {
        HStack(spacing: PKMDesign.Spacing.sm) {
            Text(title)
                .font(.system(.caption, design: .rounded).weight(.semibold))
                .frame(width: 36, alignment: .leading)
                .foregroundStyle(.white.opacity(0.95))
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.white.opacity(0.18))
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.white)
                        .frame(width: proxy.size.width * progress)
                        .opacity(0.9)
                }
            }
            .frame(height: 10)
            Text("\(value)")
                .font(.system(.caption2, design: .rounded))
                .foregroundStyle(.white.opacity(0.9))
                .frame(width: 32, alignment: .trailing)
        }
        .frame(height: 18)
    }
}

#Preview {
    StatBar(title: "", value: 0, max: 0)
}
