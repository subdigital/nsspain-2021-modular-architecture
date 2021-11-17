//
//  Series.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import Foundation

public struct Series: Codable {
    public let id: Int
    public let name: String
    public let description: String
    public let artworkImgixUrl: URL
    public let installments: [Int]
    
    public init(id: Int, name: String, description: String, artworkImgixUrl: URL, installments: [Int]) {
        self.id = id
        self.name = name
        self.description = description
        self.artworkImgixUrl = artworkImgixUrl
        self.installments = installments
    }
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
