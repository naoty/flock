//
//  HelpCommand.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/02/25.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

struct HelpCommand: Command {
    func run() -> Result {
        let helpMessage = "USAGE: flock [file ...]"
        return .success(message: helpMessage)
    }
}
