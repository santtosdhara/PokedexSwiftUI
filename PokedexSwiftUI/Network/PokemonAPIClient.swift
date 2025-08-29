//
//  PokemonNetwork.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/27/25.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable, Identifiable {
    var id: String { url }
    let name: String
    let url: String
    
    var numericID: String? {
        let parts = url.split(separator: "/").filter { !$0.isEmpty }
        return parts.last.map(String.init)
    }
}

final class PokemonAPIClient {
    
    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
    
    func getPokemonList(limit: Int = 20, offset: Int = 0) async throws -> PokemonListResponse {
        var comps = URLComponents(string: "https://pokeapi.co/api/v2/pokemon")!
        comps.queryItems = [
            .init(name: "limit", value: String(limit)),
            .init(name: "offset", value: String(offset))
        ]
        guard let url = comps.url else { throw FetchError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse else { throw FetchError.badStatus(-1) }
        guard http.statusCode == 200 else {
        #if DEBUG
            if let body = String(data: data, encoding: .utf8) { print("Body:", body) }
        #endif
            throw FetchError.badStatus(http.statusCode)
        }
        do {
            return try decoder.decode(PokemonListResponse.self, from: data)
        } catch {
            throw FetchError.decoding(error)
        }
    }
    
    
    func getPokemonDetail(_ idOrName: String) async throws -> PokemonDetail {
        let lower = idOrName.lowercased()
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(lower)") else {
            throw FetchError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse else { throw FetchError.badStatus(-1) }
        guard http.statusCode == 200 else {
        #if DEBUG
            if let body = String(data: data, encoding: .utf8) { print("Body:", body) }
        #endif
            throw FetchError.badStatus(http.statusCode)
        }
        
        do {
            return try decoder.decode(PokemonDetail.self, from: data)
        } catch {
            throw FetchError.decoding(error)
        }
    }
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}

