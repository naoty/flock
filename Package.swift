import PackageDescription

let package = Package(
    name: "flock",
    dependencies: [
        .Package(url: "https://github.com/jpsim/SourceKitten", majorVersion: 0),
        .Package(url: "https://github.com/kylef/PathKit", majorVersion: 0)
    ]
)
