//
//  ScreencastsTests.swift
//  ScreencastsTests
//
//  Created by Ben Scheirman on 11/8/21.
//

import XCTest
@testable import Screencasts

class ScreencastsTests: XCTestCase {
    func testFetchesEpisodes() async throws {
        let api = EpisodesApi()
        let episodes = try await api.loadEpisodes()
        print(episodes[0...10])
        XCTAssert(episodes.count > 500)
    }
    
    func testFetchesSeries() async throws {
        let api = SeriesApi()
        let series = try await api.loadSeries()
        print(series[0...10])
        XCTAssert(series.count > 10)
    }
}
