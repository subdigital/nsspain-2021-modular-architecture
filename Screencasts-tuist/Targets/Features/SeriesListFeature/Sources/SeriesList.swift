import SwiftUI
import DataFlow
import Models

public typealias SeriesListStore = Store<SeriesListState, SeriesListAction, SeriesListEnvironment>

public struct SeriesList: View {
    @ObservedObject var store: SeriesListStore
    
    var gridItems: [GridItem] {
        [
            GridItem(),
            GridItem()
        ]
    }
    
    public init(store: SeriesListStore) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ProgressView()
                        .opacity(store.state.isLoading ? 1 : 0)
                    
                    ForEach(store.state.series, id: \.id) { series in
                        SeriesCard(series: series)
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

struct SeriesCard: View {
    let series: Series
    
    var body: some View {
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
    }
}
