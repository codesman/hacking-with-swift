//
//  BallColor.swift
//  Pachinko
//
//  Created by Tom Holland on 5/13/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

import Foundation

enum BallColor: Int {
    case blue = 1, cyan, green, grey, purple, red, yellow
}

extension BallColor: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .blue:
            return "blue"
        case .cyan:
            return "cyan"
        case .green:
            return "green"
        case .grey:
            return "grey"
        case .purple:
            return "purple"
        case .red:
            return "red"
        case .yellow:
            return "yellow"
        }
    }
    
    var capitalized: String {
        switch self {
        case .blue:
            return "Blue"
        case .cyan:
            return "Cyan"
        case .green:
            return "Green"
        case .grey:
            return "Grey"
        case .purple:
            return "Purple"
        case .red:
            return "Red"
        case .yellow:
            return "Yellow"
        }
    }
    
    static let allValues = (BallColor.blue.rawValue...BallColor.yellow.rawValue).map {
        BallColor(rawValue: $0)
    }
}
