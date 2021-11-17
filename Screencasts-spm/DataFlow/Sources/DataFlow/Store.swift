import Foundation

public final class Store<Value, Action, Environment>: ObservableObject {
    @Published
    public var state: Value
    
    private let reducer: (inout Value, Action, Environment) -> Effect<Action>?
    private let environment: Environment
    
    public init(state: Value, reducer: @escaping (inout Value, Action, Environment) -> Effect<Action>?, environment: Environment) {
        self.state = state
        self.reducer = reducer
        self.environment = environment
    }
    
    public func send(_ action: Action) {
        if let effect = reducer(&state, action, environment) {
            Task.detached { @MainActor in
                for action in try await effect.execute() {
                    self.send(action)
                }
            }
        }
    }
    
    public func scoped<LocalValue, LocalAction, LocalEnvironment>(
        _ f: @escaping (Value) -> LocalValue,
        action: EnumKeyPath<Action, LocalAction>,
        transformEnvironment: (Environment) -> LocalEnvironment
        ) -> Store<LocalValue, LocalAction, LocalEnvironment> {
        .init(
            state: f(state),
            reducer: { [weak self] localValue, localAction, localEnv in
                guard let self = self else { return nil }
                let globalAction = action.embed(localAction)
                self.send(globalAction)
                localValue = f(self.state)
                return nil
            },
            environment: transformEnvironment(environment)
        )
    }
}
