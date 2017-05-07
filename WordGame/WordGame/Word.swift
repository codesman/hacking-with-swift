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
    
    var title: String {
        switch self {
        case .tooShort:
            return "Word too short"
        case .isStartWord:
            return "Start word entered"
        case .wasUsed:
            return "Word used already"
        case .notPossible:
            return "Word not possible"
        case .notReal:
            return "Word not recognized"
        }
    }
        
    var message: String {
        switch self {
        case .tooShort:
            return "Your words must be at least 3 characters."
        case .isStartWord:
            return "The start word doesn't count as a word!"
        case .wasUsed:
            return "Be more original!"
        case .notPossible(let titleLowercased):
            return "You can't spell that word from \(titleLowercased)"
        case .notReal:
            return "You can't just make them up, you know!"
        }
    }
}
