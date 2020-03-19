// Copyright © 2020 David N Main. All rights reserved.

import Foundation

public struct MindMapTopic {
    struct Position {
        let x: Double
        let y: Double
    }

    enum Kind {
        case child
        case callout
        case floating
    }

    enum Shape: Int {
        case rounded = 0
        case rectangle = 1
        case oval = 2
        case underline = 3
        case none = 4
        case squareBracket = 5
        case curvedBracket = 6
        case circle = 7
        case diamond = 8
        case parallelogram = 9
        case pill = 10
        case square = 11
        case triangle = 12
    }

    let uuid: String
    let position: Position
    let text: String
    let created: String
    let modified: String
    let kind: Kind
    let shape: Shape?
    let isBoundary: Bool
    let color: String?
    let note: String?
    let link: String?
    let numbering: String?
}

struct Group {

}
