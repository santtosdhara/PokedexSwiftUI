//
//  HTTPError.swift
//  PokedexSwiftUI
//
//  Created by Dhara Chavez on 8/28/25.
//

import Foundation

enum FetchError: Error {
    case invalidURL
    case transportError(Error)
    case decoding(Error)
    case badStatus(Int)
    case noDataReturned
    
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .transportError(let error): return "Network error: \(error.localizedDescription)"
        case .badStatus(let statusCode): return "Server responded with status code: \(statusCode)"
        case .decoding: return "Failed to decode server response"
        case .noDataReturned: return "No data returned from the server"
        }
    }
}
