import SwiftUI
import EpisodeListFeature
import SeriesListFeature
import DataFlow

@main
struct ScreencastsApp: App {
    @StateObject var store = Store<AppState, AppAction, Environment>(
        state: AppState(),
        reducer: appReducer,
        environment: .init(
            episodesApi: .live,
            seriesApi: .live)
    )
    
    var body: some Scene {
        WindowGroup {
            TabView {
                EpisodeList(store: store.scoped(
                    \.episodeListState,
                     action: AppAction.episodeList,
                     transformEnvironment: \.episodeList
                ))
                
                SeriesList(store: store.scoped(
                    \.seriesListState,
                     action: AppAction.seriesList,
                     transformEnvironment: \.seriesList
                ))
            }
        }
    }
}

