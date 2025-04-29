//
//  SetGame.swift
//  Set
//
//  Created by Leon Baumann on 07.04.25.
//

import Foundation

struct SetGame {
    private(set) var cardPile: [Card] = []
    private(set) var displayedCards: [Card] = []
    
    var testCard = Card(shape: Feature.two, color: Feature.one, shading: Feature.three, amount: Feature.three)
    
    init() {
        for shape in Feature.allCases {
            for color in Feature.allCases {
                for shading in Feature.allCases {
                    for amount in Feature.allCases {
                        cardPile.append(Card(
                            shape: shape,
                            color: color,
                            shading: shading,
                            amount: amount
                        ))
                    }
                }
            }
        }
        cardPile.shuffle()
        drawCards(count: 12)
    }
    
    mutating func drawCards(count: Int){
        for _ in 0..<count {
            let card = cardPile.popLast()
            if let card {
                displayedCards.append(card)
            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = displayedCards.firstIndex(where: { $0.id == card.id }) {
            switch card.selection {
                case .none:
                displayedCards[chosenIndex].selection = .selected
            default:
                displayedCards[chosenIndex].selection = .none
            }
        }
    }
    
    struct Card: Identifiable, Equatable, Hashable, CustomDebugStringConvertible {
        var id = UUID()
        
        let shape: Feature
        let color: Feature
        let shading: Feature
        let amount: Feature
        
        var selection: selectionMode = .none
        
        var debugDescription: String { "[\(shape), \(color), \(shading), \(amount)]" }
    }
    
    enum Feature: Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum selectionMode {
        case none
        case selected
        case validSet
        case invalidSet
    }
}





