//
//  ScreencastsApp.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/8/21.
//

import SwiftUI

@main
struct ScreencastsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                EpisodeList(store: .init(
                    state: .init(),
                    reducer: episodeListReducer))
                
                SeriesList(store: .init(
                    state: .init(),
                    reducer: seriesListReducer))
            }
        }
    }
}

