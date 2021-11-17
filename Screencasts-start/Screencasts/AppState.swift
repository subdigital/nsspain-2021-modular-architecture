//
//  AppState.swift
//  Screencasts
//
//  Created by Ben Scheirman on 11/8/21.
//

import Foundation

public struct AppState {
    var episodeListState: EpisodeListState = .init()
    var seriesListState: SeriesListState = .init()
}

public enum LoadingState<T> {
    case unfetched
    case fetching
    case fetched(T)
}

public extension LoadingState {
    var fetchedValue: T? {
        if case .fetched(let value) = self {
            return value
        }
        return nil
    }
}

extension LoadingState : Equatable where T : Equatable {
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

public struct Effect<Action> {
    private let block: () async throws -> [Action]
    
    static func run(_ block: @escaping () async throws -> [Action]) -> Effect {
        Effect(block: block)
    }
    
    func execute() async throws -> [Action] {
        try await block()
    }
    
    static func all(_ effects: [Effect<Action>]) -> Effect {
        Effect {
            var actions: [Action] = []
            for effect in effects {
                actions.append(contentsOf: try await effect.execute())
            }
            return actions
        }
    }
}

func combine<Value, Action>(
    _ reducers: (inout Value, Action) -> Effect<Action>?...
) -> (inout Value, Action) -> Effect<Action>? {
    return { value, action in
        var effects: [Effect<Action>] = []
        for reducer in reducers {
            if let effect = reducer(&value, action) {
                effects.append(effect)
            }
        }
        return Effect.all(effects)
    }
}

struct EnumKeyPath<Root, Value> {
    let embed: (Value) -> Root
    let extract: (Root) -> Value?
}

func pullback<LocalValue, GlobalValue, LocalAction, GlobalAction>(
    _ reducer: @escaping (inout LocalValue, LocalAction) -> Effect<LocalAction>?,
    value: WritableKeyPath<GlobalValue, LocalValue>,
    action: EnumKeyPath<GlobalAction, LocalAction>
) -> (inout GlobalValue, GlobalAction) -> Effect<GlobalAction>? {
    return { globalValue, globalAction in
        guard let localAction = action.extract(globalAction) else { return nil }
        
        let localEffect = reducer(
            &globalValue[keyPath: value],
            localAction
        )
        
        return localEffect.flatMap { e in
            Effect.run {
                let actions = try await e.execute()
                return actions.compactMap(action.embed)
            }
        }
    }
}

let appReducer = combine(
    pullback(
        episodeListReducer,
        value: \AppState.episodeListState,
        action: AppAction.episodeList
    ),
    
    pullback(
        seriesListReducer,
        value: \AppState.seriesListState,
        action: AppAction.seriesList
    )
)

let store = Store<AppState, AppAction>(state: AppState(), reducer: appReducer)
