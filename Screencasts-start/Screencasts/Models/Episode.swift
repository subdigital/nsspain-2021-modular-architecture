import Foundation

public struct Episode: Codable {
    public let id: Int
    public let title: String
    public let episodeNumber: Int
    public let slug: String
    public let description: String
    public let publishedAt: Date
    public let episodeType: EpisodeType
    public let smallArtworkUrl: URL
    public let mediumArtworkUrl: URL
    public let largeArtworkUrl: URL
}

extension Episode: Equatable { }
