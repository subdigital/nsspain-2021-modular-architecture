public struct Effect<Action> {
    private let block: () async throws -> [Action]
    
    public static func run(_ block: @escaping () async throws -> [Action]) -> Effect {
        Effect(block: block)
    }
    
    public func execute() async throws -> [Action] {
        try await block()
    }
    
    public static func all(_ effects: [Effect<Action>]) -> Effect {
        Effect {
            var actions: [Action] = []
            for effect in effects {
                actions.append(contentsOf: try await effect.execute())
            }
            return actions
        }
    }
}

