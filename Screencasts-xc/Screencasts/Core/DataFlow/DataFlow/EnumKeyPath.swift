public struct EnumKeyPath<Root, Value> {
    public let embed: (Value) -> Root
    public let extract: (Root) -> Value?
    
    public init(embed: @escaping (Value) -> Root, extract: @escaping (Root) -> Value?) {
        self.embed = embed
        self.extract = extract
    }
}
