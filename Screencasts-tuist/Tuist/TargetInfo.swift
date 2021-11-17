
public struct TargetInfo {
    public init(name: String, dependencies: [String] = []) {
        self.name = name
        self.dependencies = dependencies
    }
    
    public let name: String
    public let dependencies: [String]
}

