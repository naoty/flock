//
//  Edge.swift
//  flock
//
//  Created by Naoto Kaneko on 2017/03/03.
//  Copyright (c) 2017 Naoto Kaneko. All rights reserved.
//

enum Edge {
    case directed(from: Node, to: Node)
    case bidirected(Node, Node)
}
