//
//  PokemonNetwork.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/27/25.
//

import Foundation

enum FetchError: Error {
    case badUrl
    case badResponse
    case decoding(Error)
}

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable, Identifiable {
    // Give SwiftUI something stable to use as an id
    var id: String { url }
    let name: String
    let url: String
}

final class PokemonNetwork {
    //Connection
    
    func getPokemonList(limit: Int = 20, offset: Int = 0) async throws -> PokemonListResponse {
        var comps = URLComponents(string: "https://pokeapi.co/api/v2/pokemon")!
        comps.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        guard let url = comps.url else { throw FetchError.badUrl }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(PokemonListResponse.self, from: data)
        } catch {
            throw FetchError.decoding(error)
        }
    }
    
    func getPokemonDetail(_ idOrName: String) async throws -> PokemonDetail {
        let lower = idOrName.lowercased()
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(lower)") else { throw FetchError.badResponse }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }

        do {
            return try decoder.decode(PokemonDetail.self, from: data)
        } catch {
            throw FetchError.decoding(error)
        }
    }
}

//Extension to remove the nulls

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
