//
//  main.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/02/25.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

import Foundation

let arguments = CommandLine.arguments.dropFirst()

let command: Command
switch arguments.first {
case .some("--help"), .some("-h"):
    command = HelpCommand()
default:
    command = HelpCommand()
}

let result = command.run()
switch result {
case let .success(message):
    print(message)
    exit(0)
case let .failure(message, errorCode):
    print(message)
    exit(Int32(errorCode))
}
