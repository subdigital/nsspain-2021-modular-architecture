//
//  JSONDecoder+api.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import Foundation

public extension JSONDecoder {
    static var api: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
