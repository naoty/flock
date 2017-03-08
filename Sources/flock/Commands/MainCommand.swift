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
        var edges = Set<Edge>()

        for structure in structures {
            guard let substructures = structure.dictionary["key.substructure"] as? [[String: SourceKitRepresentable]] else {
                continue
            }
            edges.formUnion(makeEdges(fromStructures: substructures))
        }

        let digraph = Digraph(name: "flock", edges: edges)
        return .success(message: digraph.description)
    }

    private func makeEdges(fromStructures structures: [[String: SourceKitRepresentable]]) -> Set<Edge> {
        var edges = Set<Edge>()

        for structure in structures {
            guard let kindValue = structure["key.kind"] as? String else {
                continue
            }

            guard let kind = SwiftDeclarationKind(rawValue: kindValue) else {
                continue
            }

            guard [.struct, .class, .enum, .protocol].contains(kind) else {
                continue
            }

            guard let nameValue = structure["key.name"] as? String else {
                continue
            }

            let leftNode = Node(name: nameValue)

            guard let substructures = structure["key.substructure"] as? [[String: SourceKitRepresentable]] else {
                continue
            }

            let rightNodes = makeRightNodes(fromStructures: substructures)
            for rightNode in rightNodes {
                let edge = Edge(left: leftNode, right: rightNode)
                edges.insert(edge)
            }
        }

        return edges
    }

    private func makeRightNodes(fromStructures structures: [[String: SourceKitRepresentable]]) -> [Node] {
        var nodes: [Node] = []

        for structure in structures {
            guard let kindValue = structure["key.kind"] as? String else {
                continue
            }

            guard let kind = SwiftDeclarationKind(rawValue: kindValue) else {
                continue
            }

            guard [.varInstance, .varLocal, .varParameter, .varStatic].contains(kind) else {
                continue
            }

            guard let nameValue = structure["key.typename"] as? String else {
                continue
            }

            let node = Node(name: nameValue)
            nodes.append(node)

            guard let substructures = structure["key.substructure"] as? [[String: SourceKitRepresentable]] else {
                continue
            }

            let subnodes = makeRightNodes(fromStructures: substructures)
            nodes += subnodes
        }

        return nodes
    }
}
