//
//  MainCommand.swift
//  flock
//
//  Created by Naoto kaneko on 2017/02/28.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

import SourceKittenFramework

struct MainCommand: Command {
    private let structures: [Structure]

    init(paths: [String]) {
        structures = paths.map({ File(path: $0) }).flatMap({ $0 }).map({ Structure(file: $0) })
    }
    
    func run() -> Result {
        return .failure(error: .unknown)
    }
}
