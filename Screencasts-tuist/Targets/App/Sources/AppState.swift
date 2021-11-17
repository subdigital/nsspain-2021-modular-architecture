import Foundation
import DataFlow
import EpisodeListFeature
import SeriesListFeature
import Networking
import Network

public struct Environment {
    let episodesApi: EpisodesApi
    let seriesApi: SeriesApi
}

extension Environment {
    var episodeList: EpisodeListEnvironment {
        .init(episodesApi: episodesApi)
    }
    
    var seriesList: SeriesListEnvironment {
        .init(seriesApi: seriesApi)
    }
}

public struct AppState {
    var episodeListState: EpisodeListState = .init()
    var seriesListState: SeriesListState = .init()
}

public enum AppAction {
    case episodeList(EpisodeListAction)
    case seriesList(SeriesListAction)
}

extension AppAction {
    static var episodeList: EnumKeyPath<AppAction, EpisodeListAction> {
        .init(
            embed: { .episodeList($0)},
            extract: {
                if case .episodeList(let a) = $0 {
                    return a
                }
                return nil
            })
    }
    
    static var seriesList: EnumKeyPath<AppAction, SeriesListAction> {
        .init(
            embed: { .seriesList($0)},
            extract: {
                if case .seriesList(let a) = $0 {
                    return a
                }
                return nil
            })
    }
}

typealias AppReducer = (inout AppState, AppAction, Environment) -> Effect<AppAction>?
let appReducer: AppReducer = combine(
    pullback(
        EpisodeListFeature.reducer,
        value: \AppState.episodeListState,
        action: AppAction.episodeList,
        environment: \.episodeList
    ),
    
    pullback(
        SeriesListFeature.reducer,
        value: \AppState.seriesListState,
        action: AppAction.seriesList,
        environment: \.seriesList
    )
)

