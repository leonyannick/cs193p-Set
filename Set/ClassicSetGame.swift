//
//  ClassicSetGame.swift
//  Set
//
//  Created by Leon Baumann on 07.04.25.
//

import Foundation

class ClassicSetGame: ObservableObject {
    @Published private(set) var setGame = SetGame()
    
    var cards: [SetGame.Card] {
        print(setGame.cards)
        return setGame.cards
    }
    
    var testCard: SetGame.Card {
        return setGame.testCard
    }
}

