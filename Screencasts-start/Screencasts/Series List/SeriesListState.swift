//
//  SeriesListState.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import SwiftUI
import Combine

public struct SeriesListState {
    var loadingState: LoadingState<[Series]> = .unfetched
    
    var series: [Series] {
        loadingState.fetchedValue ?? []
    }
    
    var isLoading: Bool {
        loadingState == .fetching
    }
}

public enum SeriesListAction {
    case load
    case response([Series])
}

func seriesListReducer(state: inout SeriesListState, action: SeriesListAction) -> Effect<SeriesListAction>? {
    switch action {
    case .load:
        state.loadingState = .fetching
        return Effect.run {
            let api = SeriesApi()
            let series = try await api.loadSeries()
            return [.response(series)]
        }
    case .response(let series):
        state.loadingState = .fetched(series)
    }
    return nil
}
