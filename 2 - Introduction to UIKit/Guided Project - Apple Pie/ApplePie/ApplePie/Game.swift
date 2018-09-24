//
//  Game.swift
//  ApplePie
//
//  Created by Justin Snider on 9/24/18.
//  Copyright © 2018 Justin Snider. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter) "
            } else {
                guessedWord += "_ "
            }
        }
        guessedWord.removeLast()
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
}
