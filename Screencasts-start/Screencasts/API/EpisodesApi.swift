//
//  EpisodesApi.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/8/21.
//

import Foundation

public struct EpisodesApi {
    private let client = ApiClient()
    
    public init() {
    }
    
    public func loadEpisodes() async throws -> [Episode] {
        let data = try await client.fetch("episodes")
        let wrapper = try JSONDecoder.api.decode(EpisodesWrapper.self, from: data)
        return wrapper.episodes
    }
}

fileprivate struct EpisodesWrapper: Decodable {
    let episodes: [Episode]
}
