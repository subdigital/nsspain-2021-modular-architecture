import SwiftUI
import DataFlow

public typealias EpisodeListStore = Store<EpisodeListState, EpisodeListAction, EpisodeListEnvironment>

public struct EpisodeList: View {
    @ObservedObject var store: EpisodeListStore
    
    public init(store: EpisodeListStore) {
        self.store = store
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                ProgressView()
                    .opacity(store.state.isLoading ? 1 : 0)
                
                List(store.state.episodes, id: \.id) { episode in
                    HStack {
                        AsyncImage(url: episode.smallArtworkUrl, content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                        }, placeholder: {
                            ProgressView()
                        })
                            .frame(width: 80)
                        
                        Text(episode.title)
                            .lineLimit(2)
                            .font(.subheadline)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Episodes")
        }
        .tabItem {
            Label("Episodes", systemImage: "ipad.badge.play")
        }
        .task {
            if case .unfetched = store.state.loadingState {
                store.send(.load)
            }
        }
    }
}
