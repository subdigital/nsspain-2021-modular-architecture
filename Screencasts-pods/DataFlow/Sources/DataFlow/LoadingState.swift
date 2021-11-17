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
