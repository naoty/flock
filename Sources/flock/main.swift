//
//  main.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/02/25.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

import Foundation
import PathKit

let version = "0.1.0"

func main() {
    let command = makeCommand(arguments: [String](CommandLine.arguments.dropFirst()))
    let result = command.run()

    switch result {
    case let .success(message):
        print(message)
        exit(0)
    case let .failure(error):
        print(error.message)
        exit(Int32(error.code))
    }
}

func makeCommand(arguments: [String]) -> Command {
    guard let firstArgument = arguments.first else {
        let paths = allSourcePaths(directoryPath: ".")
        return MainCommand(paths: paths)
    }

    switch firstArgument {
    case "--help", "-h":
        return HelpCommand()
    case "--version", "-v":
        return VersionCommand(version: version)
    default:
        let paths = allSourcePaths(directoryPath: firstArgument)
        return MainCommand(paths: paths)
    }
}

func allSourcePaths(directoryPath: String) -> [String] {
    let absolutePath = Path(directoryPath).absolute()

    do {
        return try absolutePath.recursiveChildren().filter({ $0.extension == "swift" }).map({ $0.string })
    } catch {
        return []
    }
}

main()
