//
//  ApiClient.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/8/21.
//

import Foundation

public struct ApiClient {
    public enum HttpError: Error {
        case invalidResponse
        case serverError(Int)
        case requestError(Int)
        case connectionError(Error)
    }
    
    private let session: URLSession
    
    public init() {
        session = URLSession(configuration: .default)
    }

    var baseURL = URL(string: "https://nsscreencast.com/api/")!
    
    func fetch(_ path: String) async throws -> Data {
        let url = baseURL.appendingPathComponent(path)
        return try await fetch(url)
    }
    
    func fetch(_ url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url, delegate: nil)
        guard let http = response as? HTTPURLResponse else {
            throw HttpError.invalidResponse
        }
        switch http.statusCode {
        case 500...599: throw HttpError.serverError(http.statusCode)
        case 400...499: throw HttpError.requestError(http.statusCode)
        default:
            return data
        }
    }
}
