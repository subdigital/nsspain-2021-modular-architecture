//
//  SeriesApi.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import Foundation
import Models

public struct SeriesApi {
    public let loadSeries: () async throws -> [Series]
    
    public init(loadSeries: @escaping () async throws -> [Series]) {
        self.loadSeries = loadSeries
    }
}

public extension SeriesApi {
    static var live: Self {
        let client = ApiClient()
        return .init(
            loadSeries: {
                let data = try await client.fetch("series")
                let wrapper = try JSONDecoder.api.decode(SeriesWrapper.self, from: data)
                return wrapper.series
            })
    }
    
    private struct SeriesWrapper: Decodable {
        let series: [Series]
    }
}

#if DEBUG
public extension SeriesApi {
    static var stub: Self {
        .init(loadSeries: {
            let dummyURL = URL(string: "https://picsum.photos/200/140")!
            return [
                .init(id: 1, name: "Working with Bools", description: "", artworkImgixUrl: dummyURL, installments: []),
                .init(id: 2, name: "Wrestling with Xcode", description: "", artworkImgixUrl: dummyURL, installments: [])
            ]
        })
    }
}
#endif
