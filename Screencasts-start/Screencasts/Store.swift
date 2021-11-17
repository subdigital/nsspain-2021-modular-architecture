//
//  Store.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/9/21.
//

import Foundation

final class Store<State, Action>: ObservableObject {
    @Published
    var state: State
    let reducer: (inout State, Action) -> Effect<Action>?
    
    init(state: State, reducer: @escaping (inout State, Action) -> Effect<Action>?) {
        self.state = state
        self.reducer = reducer
    }
    
    func send(_ action: Action) {
        print("📡 \(action)")
        if let effect = reducer(&state, action) {
            Task.detached { @MainActor in
                for action in try await effect.execute() {
                    self.send(action)
                }
            }
        }
    }
}
