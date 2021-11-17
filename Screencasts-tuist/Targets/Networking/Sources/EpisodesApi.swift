import Foundation
import Models

public struct EpisodesApi {
    public let loadEpisodes: () async throws -> [Episode]
}

public extension EpisodesApi {
    static var live: Self {
        let client = ApiClient()
        return .init(
            loadEpisodes: {
            let data = try await client.fetch("episodes")
            let wrapper = try JSONDecoder.api.decode(EpisodesWrapper.self, from: data)
            return wrapper.episodes
        })
    }

    private struct EpisodesWrapper: Decodable {
        let episodes: [Episode]
    }
}

#if DEBUG
public extension EpisodesApi {
    static var stub: Self {
        let dummyURL = URL(string: "https://placekitten.com/100/50")!
        return .init(loadEpisodes: {
          return [
            Episode(id: 1, title: "Intro to Swift", episodeNumber: 1, slug: "intro", description: "", publishedAt: Date(), episodeType: .free, smallArtworkUrl: dummyURL, mediumArtworkUrl: dummyURL, largeArtworkUrl: dummyURL),
            Episode(id: 2, title: "Core Data for Squirrels", episodeNumber: 2, slug: "cds", description: "", publishedAt: Date(), episodeType: .free, smallArtworkUrl: dummyURL, mediumArtworkUrl: dummyURL, largeArtworkUrl: dummyURL)
          ]
        })
    }
}
#endif
