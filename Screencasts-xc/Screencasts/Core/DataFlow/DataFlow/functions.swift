public func combine<Value, Action, Env>(
    _ reducers: (inout Value, Action, Env) -> Effect<Action>?...
) -> (inout Value, Action, Env) -> Effect<Action>? {
    return { value, action, env in
        var effects: [Effect<Action>] = []
        for reducer in reducers {
            if let effect = reducer(&value, action, env) {
                effects.append(effect)
            }
        }
        return Effect.all(effects)
    }
}

public func pullback<
    LocalValue, GlobalValue,
    LocalAction, GlobalAction,
    GlobalEnvironment, LocalEnvironment
>(
    _ reducer: @escaping (inout LocalValue, LocalAction, LocalEnvironment) -> Effect<LocalAction>?,
    value: WritableKeyPath<GlobalValue, LocalValue>,
    action: EnumKeyPath<GlobalAction, LocalAction>,
    environment: KeyPath<GlobalEnvironment, LocalEnvironment>
) -> (inout GlobalValue, GlobalAction, GlobalEnvironment) -> Effect<GlobalAction>? {
    return { globalValue, globalAction, globalEnv in
        guard let localAction = action.extract(globalAction) else { return nil }
        
        let localEffect = reducer(
            &globalValue[keyPath: value],
            localAction,
            globalEnv[keyPath: environment]
        )
        
        return localEffect.flatMap { e in
            Effect.run {
                let actions = try await e.execute()
                return actions.compactMap(action.embed)
            }
        }
    }
}
