import SwiftUI
import EpisodeListFeature
import DataFlow
import Networking
import EpisodeListFeature

@main
struct EpisodeListDemoApp: App {
    @StateObject var store = EpisodeListStore(
        state: .init(),
        reducer: EpisodeListFeature.reducer,
        environment: .init(episodesApi: .stub)
    )
    var body: some Scene {
        WindowGroup {
            EpisodeList(store: store)
        }
    }
}
