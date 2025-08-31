//
//  Color+PokemonType.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/30/25.
//

import SwiftUI

public extension Color {
    static func typeColor(_ type: String) -> Color {
        switch type.lowercased() {
        case "grass": return Color(hex: 0x48D0B0)
        case "fire": return Color(hex: 0xFB6C6C)
        case "water": return Color(hex: 0x76BEFE)
        case "bug": return Color(hex: 0xA8B820)
        case "normal": return Color(hex: 0xA8A77A)
        case "electric": return Color(hex: 0xF8D030)
        case "ground": return Color(hex: 0xE0C068)
        case "fairy": return Color(hex: 0xEE99AC)
        case "fighting": return Color(hex: 0xC03028)
        case "psychic": return Color(hex: 0xF85888)
        case "rock": return Color(hex: 0xB8A038)
        case "ghost": return Color(hex: 0x735797)
        case "ice": return Color(hex: 0x98D8D8)
        case "dragon": return Color(hex: 0x7038F8)
        case "poison": return Color(hex: 0xA040A0)
        case "steel": return Color(hex: 0xB7B7CE)
        case "flying": return Color(hex: 0xA890F0)
        case "dark": return Color(hex: 0x705746)
        default: return .gray
        }
    }
}
