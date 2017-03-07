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
        var edges: [Edge] = []

        for structure in structures {
            guard let substructures = structure.dictionary["key.substructure"] as? [[String: SourceKitRepresentable]] else {
                return .failure(error: .unknown)
            }

            for substrucure in substructures {
                guard let kindValue = substrucure["key.kind"] as? String else {
                    continue
                }

                guard let kind = SwiftDeclarationKind(rawValue: kindValue) else {
                    continue
                }

                guard let nameValue = substrucure["key.name"] as? String else {
                    continue
                }

                switch kind {
                case .struct, .class, .protocol:
                    let edge = Edge.directed(from: Node(name: nameValue), to: Node(name: ""))
                    edges.append(edge)
                default:
                    continue
                }
            }
        }

        let digraph = Digraph(name: "flock", edges: edges)
        return .success(message: digraph.description)
    }
}
