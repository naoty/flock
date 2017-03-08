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

extension Edge: Equatable {
    static func == (left: Edge, right: Edge) -> Bool {
        return left.left == right.left && left.right == right.right
    }
}

extension Edge: Hashable {
    var hashValue: Int {
        return left.hashValue ^ right.hashValue
    }
}
