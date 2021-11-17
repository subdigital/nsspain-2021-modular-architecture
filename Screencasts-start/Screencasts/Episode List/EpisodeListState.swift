//
//  EpisodeListState.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import Foundation

public struct EpisodeListState {
    var loadingState: LoadingState<[Episode]> = .unfetched
    
    var episodes: [Episode] {
        loadingState.fetchedValue ?? []
    }
    
    var isLoading: Bool {
        loadingState == .fetching
    }
}

public enum EpisodeListAction {
    case load
    case response([Episode])
}

func episodeListReducer(state: inout EpisodeListState, action: EpisodeListAction) -> Effect<EpisodeListAction>? {
    switch action {
    case .load:
        state.loadingState = .fetching
        return Effect.run {
            let api = EpisodesApi()
            let episodes = try await api.loadEpisodes()
            return [.response(episodes)]
        }
    case .response(let episodes):
        state.loadingState = .fetched(episodes)
    }
    return nil
}
