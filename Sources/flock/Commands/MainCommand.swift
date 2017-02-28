//
//  MainCommand.swift
//  flock
//
//  Created by Naoto kaneko on 2017/02/28.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

struct MainCommand: Command {
    func run() -> Result {
        return .success(message: "The main command run")
    }
}
