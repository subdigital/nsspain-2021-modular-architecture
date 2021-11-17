import Foundation
import XCTest
@testable import Models

final class ModelsTests: XCTestCase {
    func testSeriesArtworkSizeURL() {
        let series = Series(id: 1, name: "MySeries", description: "", artworkImgixUrl: URL(string: "https://example.com/image.png")!, installments: [])
        XCTAssertEqual(
            series.smallArtworkURL.absoluteString,
            "https://example.com/image.png?w=200&dpr=2"
        )
    }
}
