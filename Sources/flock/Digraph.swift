//
//  Digraph.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/03/03.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

struct Digraph: CustomStringConvertible {
    let name: String
    let edges: Set<Edge>

    private let indent = "  "

    var description: String {
        var buffer: [String] = []
        buffer.append("digraph \(name) {")

        for edge in edges {
            buffer.append("\(indent)\(edge)")
        }

        buffer.append("}")

        return buffer.joined(separator: "\n")
    }
}
