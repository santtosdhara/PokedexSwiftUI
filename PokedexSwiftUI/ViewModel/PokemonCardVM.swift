//
//  PokemonCardVM.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/30/25.
//

import Foundation

public struct PokemonCardVM: Identifiable, Hashable {
    public let id: Int
        public let name: String
        public let imageURL: URL?
        public let types: [String]
        public let height: Int?
        public let weight: Int?
        public let baseStats: [String: Int]
        public var isFavorite: Bool = false

        public init(
            id: Int,
            name: String,
            imageURL: URL?,
            types: [String],
            height: Int?,
            weight: Int?,
            baseStats: [String : Int],
            isFavorite: Bool = false
        ) {
            self.id = id
            self.name = name
            self.imageURL = imageURL
            self.types = types
            self.height = height
            self.weight = weight
            self.baseStats = baseStats
            self.isFavorite = isFavorite
        }
}

public extension PokemonCardVM {
    var displayNumber: String { String(format: "#%03d", id) }
    var displayName: String { name.capitalized }
    var displayHeight: String? {
        guard let h = height else { return nil }
        return String(format: "%.1f m", Double(h) / 10.0)
    }
    var displayWeight: String? {
        guard let w = weight else { return nil }
        return String(format: "%.1f kg", Double(w) / 10.0)
    }
}
