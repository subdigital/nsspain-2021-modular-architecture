//
//  Series.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import Foundation

public struct Series: Codable {
    let id: Int
    let name: String
    let description: String
    let artworkImgixUrl: URL
    let installments: [Int]
}

public extension Series {
    var smallArtworkURL: URL {
        var components = URLComponents(url: artworkImgixUrl, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "w", value: "200"),
            URLQueryItem(name: "dpr", value: "2")
        ]
        return components.url!
    }
}

extension Series: Equatable {
}
