import ProjectDescription

let bundleIdPrefix = "com.nsspain.modular-architecture"

public struct TargetInfo {
    public init(name: String, dependencies: [String] = []) {
        self.name = name
        self.dependencies = dependencies
    }
    
    public let name: String
    public let dependencies: [String]
}

extension Project {
    public static func app(
        name: String,
        platform: Platform,
        featureTargets: [TargetInfo],
        additionalTargets: [TargetInfo]
    ) -> Project {
        
        let additionalTargetDependencies = additionalTargets.map { TargetDependency.target(name: $0.name) }
        let featureModuleDependencies = featureTargets.map { TargetDependency.target(name: $0.name) }
        var targets = makeAppTargets(name: name,
                                     platform: platform,
                                     dependencies:
                                        additionalTargetDependencies + featureModuleDependencies)
        
        targets += additionalTargets.flatMap({
            makeFrameworkTargets(
                name: $0.name,
                platform: platform,
                dependencies: $0.dependencies.map(TargetDependency.target)
            )
        })
        targets += featureTargets.flatMap({
            makeFrameworkTargets(
                folder: "Targets/Features",
                name: $0.name,
                platform: platform,
                dependencies:
                    $0.dependencies.map(TargetDependency.target) +
                    additionalTargets.map(\.name).map(TargetDependency.target)
            )
        })
        
        return Project(name: name,
                       organizationName: "NSSpain",
                       targets: targets)
    }
    
    static func demoApp() {
        
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(folder: String = "Targets", name: String, platform: Platform, dependencies: [TargetDependency] = []) -> [Target] {
        let sources = Target(name: name,
                platform: platform,
                product: .framework,
                bundleId: "\(bundleIdPrefix).\(name)",
                infoPlist: .default,
                sources: ["\(folder)/\(name)/Sources/**"],
                resources: [],
                dependencies: dependencies)
        let tests = Target(name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "\(bundleIdPrefix).\(name)Tests",
                infoPlist: .default,
                sources: ["\(folder)/\(name)/Tests/**"],
                resources: [],
                dependencies: [.target(name: name)])
        return [sources, tests]
    }
    
    private static func makeAppTargets(folder: String = "Targets",
                                       name: String,
                                       platform: Platform,
                                       dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
            ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "\(bundleIdPrefix).\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["\(folder)/\(name)/Sources/**"],
            resources: ["\(folder)/\(name)/Resources/**"],
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(bundleIdPrefix).\(name)Tests",
            infoPlist: .default,
            sources: ["\(folder)/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
}
