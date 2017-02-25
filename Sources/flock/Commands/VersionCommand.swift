//
//  VersionCommand.swift
//  flock
//
//  Created by naoto kaneko on 2017/02/25.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

struct VersionCommand: Command {
    let version: String

    func run() -> Result {
        return .success(message: version)
    }
}
