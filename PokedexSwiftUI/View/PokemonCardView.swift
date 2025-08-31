//
//  PokemonCardView.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/30/25.
//

import SwiftUI

public struct PokemonCardView: View {
    @State private var vm: PokemonCardVM
    public var onTap: (() -> Void)?
    public var onToggleFavorite: ((Bool) -> Void)?
    
    public init(vm: PokemonCardVM, onTap: (() -> Void)? = nil) {
        self.vm = vm
        self.onTap = onTap
    }
    public var body: some View {
        Button(action: { onTap?() }) {
            ZStack {
                background
                content
            }
            .clipShape(RoundedRectangle(cornerRadius: PKMDesign.Radius.lg, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: PKMDesign.Radius.lg)
                    .strokeBorder(Color.white.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: PKMDesign.Shadow.card, radius: 10, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(vm.displayName), \(vm.types.first ?? "Unknown") type, \(vm.displayNumber)")
    }
}

private extension PokemonCardView {
    var background: some View {
        let primary = Color.typeColor(vm.types.first ?? "")
        let secondary = Color.typeColor(vm.types.dropFirst().first ?? vm.types.first ?? "").opacity(0.7)
        return LinearGradient(
            gradient: Gradient(colors: [primary, secondary]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    var content: some View {
        VStack(alignment: .leading, spacing: PKMDesign.Spacing.md) {
            header
            HStack(alignment: .center, spacing: PKMDesign.Spacing.lg) {
                sprite
                info
            }
            stats
        }
        .padding(PKMDesign.Spacing.lg)
    }

    var header: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 2) {
                Text(vm.displayName)
                    .font(.system(.title3, design: .rounded).weight(.bold))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                HStack(spacing: PKMDesign.Spacing.xs) {
                    ForEach(vm.types, id: \.self) { type in
                        TypeChip(type: type)
                    }
                }
            }
            Spacer()
            Text(vm.displayNumber)
                .font(.system(.subheadline, design: .rounded).weight(.semibold))
                .foregroundStyle(.white.opacity(0.9))
                .padding(.horizontal, PKMDesign.Spacing.sm)
                .padding(.vertical, PKMDesign.Spacing.xs)
                .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: PKMDesign.Radius.sm, style: .continuous))
                .accessibilityHidden(true)

            FavoriteButton(isOn: vm.isFavorite) {
                vm.isFavorite.toggle()
                onToggleFavorite?(vm.isFavorite)
            }
            .accessibilityLabel(vm.isFavorite ? "Remove from favorites" : "Add to favorites")
        }
    }

    var sprite: some View {
        ZStack {
            Circle()
                .fill(.white.opacity(0.18))
                .frame(width: 108, height: 108)
            if let url = vm.imageURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 96, height: 96)
                            .shadow(radius: 2, x: 0, y: 2)
                    case .failure:
                        Image(systemName: "questionmark.square.dashed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .foregroundStyle(.white.opacity(0.8))
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
        .accessibilityHidden(true)
    }

    var info: some View {
        VStack(alignment: .leading, spacing: PKMDesign.Spacing.sm) {
            if let h = vm.displayHeight { LabeledValue(label: "Height", value: h) }
            if let w = vm.displayWeight { LabeledValue(label: "Weight", value: w) }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var stats: some View {
        VStack(alignment: .leading, spacing: PKMDesign.Spacing.xs) {
            ForEach(orderedStats(vm.baseStats), id: \.0) { key, val in
                StatBar(title: statDisplayName(key), value: val, max: 255)
            }
        }
        .padding(.top, PKMDesign.Spacing.sm)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Base stats")
    }

    // Canonicalize stat keys and return in a stable UI order
    func orderedStats(_ dict: [String:Int]) -> [(String, Int)] {
        let map: [String: String] = [
            "hp": "hp",
            "attack": "atk",
            "defense": "def",
            "special-attack": "spa",
            "special defense": "spd", // in case a space sneaks in
            "special-defense": "spd",
            "speed": "spe",
            // already canonical
            "atk": "atk", "def": "def", "spa": "spa", "spd": "spd", "spe": "spe"
        ]

        var pairs: [(String, Int)] = []
        for (rawKey, value) in dict {
            let lower = rawKey.lowercased()
            let canonical = map[lower] ?? lower
            pairs.append((canonical, value))
        }

        let order = ["hp", "atk", "def", "spa", "spd", "spe"]
        return pairs.sorted { a, b in
            (order.firstIndex(of: a.0) ?? Int.max) < (order.firstIndex(of: b.0) ?? Int.max)
        }
    }

    func statDisplayName(_ key: String) -> String {
        switch key {
        case "hp": return "HP"
        case "atk": return "ATK"
        case "def": return "DEF"
        case "spa": return "SpA"
        case "spd": return "SpD"
        case "spe": return "SPE"
        default: return key.uppercased()
        }
    }
}

#Preview("PokemonCardView") {
    let sample = PokemonCardVM(
        id: 1,
        name: "bulbasaur",
        imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"),
        types: ["grass", "poison"],
        height: 7,
        weight: 69,
        baseStats: ["hp": 45, "attack": 49, "defense": 49, "special-attack": 65, "special-defense": 65, "speed": 45],
        isFavorite: true
    )
    PokemonCardView(vm: sample)
        .padding()
        .previewLayout(.sizeThatFits)
}
