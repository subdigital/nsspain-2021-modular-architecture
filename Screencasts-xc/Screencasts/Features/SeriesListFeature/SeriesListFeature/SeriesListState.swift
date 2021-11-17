import SwiftUI
import Combine
import Models
import Networking
import DataFlow

public struct SeriesListEnvironment {
    public let seriesApi: SeriesApi
    
    public init(seriesApi: SeriesApi) {
        self.seriesApi = seriesApi
    }
}

public struct SeriesListState {
    var loadingState: LoadingState<[Series]> = .unfetched
    
    var series: [Series] {
        loadingState.fetchedValue ?? []
    }
    
    var isLoading: Bool {
        loadingState == .fetching
    }
    
    public init() {
    }
}

public enum SeriesListAction {
    case load
    case response([Series])
}

public func reducer(_ state: inout SeriesListState, _ action: SeriesListAction, _ environment: SeriesListEnvironment) -> Effect<SeriesListAction>? {
    switch action {
    case .load:
        state.loadingState = .fetching
        return Effect.run {
            let api = environment.seriesApi
            let series = try await api.loadSeries()
            return [.response(series)]
        }
    case .response(let series):
        state.loadingState = .fetched(series)
    }
    return nil
}
