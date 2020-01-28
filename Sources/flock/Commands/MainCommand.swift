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
        do {
        structures = try paths.map({ File(path: $0) }).compactMap({ $0 }).map({ try Structure(file: $0) })
        }
        catch {
            print("There was a serious error")
            structures = []
        }
    }

    func run() -> Result {
        let edges = makeEdges()
        let digraph = Digraph(name: "flock", edges: edges)
        return .success(message: digraph.description)
    }

    private func makeEdges() -> Set<Edge> {
        var edges = Set<Edge>()
        var leftNodes = Set<Node>()

        for structure in structures {
            guard let substructures = structure.dictionary["key.substructure"] as? [[String: SourceKitRepresentable]] else {
                continue
            }

            for substructure in substructures {
                guard let kindValue = substructure["key.kind"] as? String else {
                    continue
                }

                guard let kind = SwiftDeclarationKind(rawValue: kindValue) else {
                    continue
                }

                guard [.struct, .class, .enum, .protocol].contains(kind) else {
                    continue
                }

                guard let nameValue = substructure["key.name"] as? String else {
                    continue
                }

                let leftNode = Node(name: nameValue)
                leftNodes.insert(leftNode)

                if let inheritedTypes = substructure["key.inheritedtypes"] as? [[String: SourceKitRepresentable]] {
                    for inheritedType in inheritedTypes {
                        guard let inheritedTypeName = inheritedType["key.name"] as? String else {
                            continue
                        }

                        let rightNode = Node(name: inheritedTypeName)
                        if leftNode == rightNode {
                            continue
                        }

                        let edge = Edge(left: leftNode, right: rightNode)
                        edges.insert(edge)
                    }
                }

                guard let subsubstructures = substructure["key.substructure"] as? [[String: SourceKitRepresentable]] else {
                    continue
                }

                let rightNodes = makeRightNodes(fromStructures: subsubstructures)
                for rightNode in rightNodes {
                    if leftNode == rightNode {
                        continue
                    }

                    let edge = Edge(left: leftNode, right: rightNode)
                    edges.insert(edge)
                }
            }
        }

        // Filter out edges which right nodes are not included in left nodes
        edges = Set<Edge>(edges.filter({ leftNodes.contains($0.right) }))

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
