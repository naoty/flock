//
//  Node.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/03/03.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

struct Node: CustomStringConvertible {
    let name: String

    var description: String {
        return name
    }
}

extension Node: Equatable {
    static func == (left: Node, right: Node) -> Bool {
        return left.name == right.name
    }
}

extension Node: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
}
