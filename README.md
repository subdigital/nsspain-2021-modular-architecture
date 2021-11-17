# Modular Project Architecture

This is the example code from my talk at [NSSpain 2021](https://nsspain.com). It is a small application that has 2 screens:

- Episode list
- Series List

There is a starting project with everything in a single project. Then the project has been split into modules:

- Models (Codable models used by the application)
- Networking (API clients)
- DataFlow (architectural pattern with stores, reducers, and actions)

Each of the features has been broken out into their own modules as well:

- EpisodeListFeature
- SeriesListFeature

See the examples in this repo for some strategies on how to accomplish this.

- Nested Xcode projects
- Swift Package Manager
- Tuist
- CocoaPods & Xcodegen

