import Foundation
import Models
import DataFlow
import Networking

public struct EpisodeListEnvironment {
    public var episodesApi: EpisodesApi
    
    public init(episodesApi: EpisodesApi) {
        self.episodesApi = episodesApi
    }
}

public struct EpisodeListState {
    public var loadingState: LoadingState<[Episode]> = .unfetched
    
    public var episodes: [Episode] {
        loadingState.fetchedValue ?? []
    }
    
    public var isLoading: Bool {
        loadingState == .fetching
    }
    
    public init() {
    }
}

public enum EpisodeListAction {
    case load
    case response([Episode])
}

public enum EpisodeListFeature {
    public static func reducer(_ state: inout EpisodeListState, _ action: EpisodeListAction, _ environment: EpisodeListEnvironment) -> Effect<EpisodeListAction>? {
        switch action {
        case .load:
            state.loadingState = .fetching
            return Effect.run {
                let episodes = try await environment.episodesApi.loadEpisodes()
                return [.response(episodes)]
            }
        case .response(let episodes):
            state.loadingState = .fetched(episodes)
        }
        return nil
    }
}
