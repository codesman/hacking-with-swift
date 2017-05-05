//
//  Word.swift
//  WordGame
//
//  Created by Tom Holland on 5/5/17.
//  Copyright © 2017 Tom Holland. All rights reserved.
//

enum Word {
    case tooShort
    case isStartWord
    case wasUsed
    case notPossible(String)
    case notReal
    
    func error() -> [String: String] {
        switch self {
        case .tooShort:
            return ["title": "Word too short", "message": "Your words must be at least 3 characters."]
        case .isStartWord:
            return ["title": "Start word entered", "message": "The start word doesn't count as a word!"]
        case .wasUsed:
            return ["title": "Word used already", "message": "Be more original!"]
        case .notPossible(let titleLowercased):
            return ["title": "Word not possible", "message": "You can't spell that word from \(titleLowercased)"]
        case .notReal:
            return ["title": "Word not recognized", "message": "You can't just make them up, you know!"]
        }
    }
}
