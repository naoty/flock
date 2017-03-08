//
//  Edge.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/03/03.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

struct Edge: CustomStringConvertible {
    let left: Node
    let right: Node

    var description: String {
        return "\"\(left)\" -> \"\(right)\";"
    }
}
