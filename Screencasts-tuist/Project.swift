import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(name: "App",
                          platform: .iOS,
                          featureTargets: [
                            .init(name: "EpisodeListFeature"),
                            .init(name: "SeriesListFeature")
                          ],
                          additionalTargets: [
                            .init(name: "Models"),
                            .init(name: "Networking", dependencies: ["Models"]),
                            .init(name: "DataFlow")
                          ])

