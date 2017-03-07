//
//  Edge.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/03/03.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

enum Edge: CustomStringConvertible {
    case directed(from: Node, to: Node)

    var description: String {
        switch self {
        case let .directed(left, _):
            return "\(left)"
        }
    }
}
