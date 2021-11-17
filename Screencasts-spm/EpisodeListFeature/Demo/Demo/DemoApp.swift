//
//  DemoApp.swift
//  Demo
//
//  Created by Ben Scheirman on 11/14/21.
//

import SwiftUI
import EpisodeListFeature

@main
struct DemoApp: App {
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
