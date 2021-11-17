//
//  SeriesList.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import SwiftUI

public struct SeriesList: View {
    @ObservedObject var store: Store<SeriesListState, SeriesListAction>
    
    var gridItems: [GridItem] {
        [
            .init(.adaptive(minimum: 140, maximum: 240), spacing: 10, alignment: .top)
        ]
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ProgressView()
                        .opacity(store.state.isLoading ? 1 : 0)
                    
                    ForEach(store.state.series, id: \.id) { series in
                        VStack {
                            AsyncImage(url: series.smallArtworkURL,
                                       content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            },
                                       placeholder: { ProgressView().padding() })
                            
                            Text(series.name)
                                .font(.headline)
                                .padding(.top, 2)
                                .padding(.bottom, 6)
                                .padding(.horizontal, 4)
                        }
                        .background(
                            Color(.sRGB, white: 0.9, opacity: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 2)
                        .transformEffect(.init(rotationAngle: -.pi / 64))
                    }
                }
                .padding()
            }
            .navigationTitle("Series")
        }
        .tabItem {
            Label("Series", systemImage: "list.bullet.below.rectangle")
        }
        .task {
            if case .unfetched = store.state.loadingState {
                store.send(.load)
            }
        }
    }
}
