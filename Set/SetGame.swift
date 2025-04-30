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
    private(set) var potentialSet: [Card] = []
    
//    private var numberOfSelectedCards = 0
    private var validSet = false
    
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
        //cardPile.shuffle()
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
            if potentialSet.count == 2 || potentialSet.count == 1 || potentialSet.isEmpty {
                switch card.selection {
                case .none:
                    print("unselected card")
                    displayedCards[chosenIndex].selection = .selected
                    potentialSet.append(card)
                default:
                    print("selected card")
                    displayedCards[chosenIndex].selection = .none
                    potentialSet.removeAll { $0.id == card.id }
                }
            }
            else {
                if validSet {
                    switch card.selection {
                    case .validSet:
                        break
                    default:
                        
                        print("n: \(displayedCards.count)")
                        for card in potentialSet {
                            if let index = displayedCards.firstIndex(where: { $0.id == card.id }) {
                                displayedCards.remove(at: index)
                            }
                        }
                        potentialSet.removeAll()
                        displayedCards[chosenIndex].selection = .selected
                        potentialSet.append(card)
                        print("n2: \(displayedCards.count)")
                        drawCards(count: 3)
                        validSet = false
                        
                    }
                }
                else {
                    for card in potentialSet {
                        if let index = displayedCards.firstIndex(where: { $0.id == card.id }) {
                            displayedCards[index].selection = .none
                        }
                    }
                    potentialSet.removeAll()
                    displayedCards[chosenIndex].selection = .selected
                    potentialSet.append(card)
                }
                
            }
            
            if potentialSet.count == 3 {
                print("valid set")
                if checkForSet() {
                    validSet = true
                    for card in potentialSet {
                        if let index = displayedCards.firstIndex(where: { $0.id == card.id }) {
                            displayedCards[index].selection = .validSet
                        }
                    }
                } else {
                    print("invalid set")
                    validSet = false
                    for card in potentialSet {
                        if let index = displayedCards.firstIndex(where: { $0.id == card.id }) {
                            displayedCards[index].selection = .invalidSet
                        }
                    }
                }
            }
        }
    }
    
    private mutating func checkForSet() -> Bool {
        if potentialSet.count != 3 {
            print("error")
            return false
        }
        let cardOne = potentialSet[0]
        let cardTwo = potentialSet[1]
        let cardThree = potentialSet[2]
        
        if !checkEqualityOfFeature(cardOne.shape, cardTwo.shape, cardThree.shape) &&
            !checkUniquenessOfFeature(cardOne.shape, cardTwo.shape, cardThree.shape) {
            print("shape")
            return false }
        if !checkEqualityOfFeature(cardOne.color, cardTwo.color, cardThree.color) &&
            !checkUniquenessOfFeature(cardOne.color, cardTwo.color, cardThree.color) {
            print("color")
            return false }
        if !checkEqualityOfFeature(cardOne.shading, cardTwo.shading, cardThree.shading) &&
            !checkUniquenessOfFeature(cardOne.shading, cardTwo.shading, cardThree.shading) {
            print("shading")
            return false }
        if !checkEqualityOfFeature(cardOne.amount, cardTwo.amount, cardThree.amount) &&
            !checkUniquenessOfFeature(cardOne.amount, cardTwo.amount, cardThree.amount) {
            print("amount")
            return false }
        return true
    }
    
    private func checkEqualityOfFeature(_ one: Feature, _ two: Feature, _ three: Feature) -> Bool {
        one == two && two == three
    }
    
    private func checkUniquenessOfFeature(_ one: Feature, _ two: Feature, _ three: Feature) -> Bool {
        one != two && two != three && one != three
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





