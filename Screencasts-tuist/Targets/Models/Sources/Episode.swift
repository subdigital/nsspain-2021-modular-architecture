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
    
    public init(id: Int, title: String, episodeNumber: Int, slug: String, description: String, publishedAt: Date, episodeType: EpisodeType, smallArtworkUrl: URL, mediumArtworkUrl: URL, largeArtworkUrl: URL) {
        self.id = id
        self.title = title
        self.episodeNumber = episodeNumber
        self.slug = slug
        self.description = description
        self.publishedAt = publishedAt
        self.episodeType = episodeType
        self.smallArtworkUrl = smallArtworkUrl
        self.mediumArtworkUrl = mediumArtworkUrl
        self.largeArtworkUrl = largeArtworkUrl
    }
}

extension Episode: Equatable { }
