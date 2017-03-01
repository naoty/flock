//
//  Error.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/03/01.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

enum Error: Swift.Error {
    case unknown
    case cannotReadContent(path: String)

    var message: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case let .cannotReadContent(path):
            return "Cannot read content from \(path)"
        }
    }

    var code: Int {
        return 1
    }
}
