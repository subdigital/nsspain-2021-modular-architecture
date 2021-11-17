//
//  SeriesApi.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import Foundation

public struct SeriesApi {
    private let client = ApiClient()
    
    public init() {
    }
    
    public func loadSeries() async throws -> [Series] {
        let data = try await client.fetch("series")
        let wrapper = try JSONDecoder.api.decode(SeriesWrapper.self, from: data)
        return wrapper.series
    }
}

fileprivate struct SeriesWrapper: Decodable {
    let series: [Series]
}
