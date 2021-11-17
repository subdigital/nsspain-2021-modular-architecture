import SwiftUI
import SeriesListFeature

@main
struct SeriesListDemoApp: App {
    @StateObject var store = SeriesListStore(
        state: .init(),
        reducer: SeriesListFeature.reducer,
        environment: .init(seriesApi: .stub))
    var body: some Scene {
        WindowGroup {
            SeriesList(store: store)
        }
    }
}
