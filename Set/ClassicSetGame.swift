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
        return setGame.displayedCards
    }
    
    var testCard: SetGame.Card {
        return setGame.testCard
    }
    
    func choose(_ card: SetGame.Card) {
        setGame.choose(card)
    }
}

