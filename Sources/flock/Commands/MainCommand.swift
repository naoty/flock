//
//  MainCommand.swift
//  flock
//
//  Created by Naoto kaneko on 2017/02/28.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

import SourceKittenFramework

struct MainCommand: Command {
    private let structure: Structure?
    private var error: Error?

    init(path: String) {
        guard let file = File(path: path) else {
            structure = nil
            error = .cannotReadContent(path: path)
            return
        }

        structure = Structure(file: file)
    }
    
    func run() -> Result {
        if let error = self.error {
            return .failure(error: error)
        }

        if let structure = structure {
            return .success(message: structure.description)
        }

        return .failure(error: .unknown)
    }
}
