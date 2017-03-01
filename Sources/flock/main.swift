//
//  main.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/02/25.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

import Foundation

let version = "0.1.0"
let arguments = CommandLine.arguments.dropFirst()

let command: Command
switch arguments.first {
case .some("--help"), .some("-h"):
    command = HelpCommand()
case .some("--version"), .some("-v"):
    command = VersionCommand(version: version)
case let path?:
    command = MainCommand(path: path)
default:
    command = HelpCommand()
}

let result = command.run()
switch result {
case let .success(message):
    print(message)
    exit(0)
case let .failure(error):
    print(error.message)
    exit(Int32(error.code))
}
