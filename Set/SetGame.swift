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
    
    private(set) var validSet = false
    
    var gameEnded: Bool {
        (cardPile.isEmpty && displayedCards.count == 3) ? true : false
    }
    
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
    
    mutating func dealThreeMoreCards () {
        if validSet {
            replaceCards(potentialSet)
        } else {
            drawCards(count: 3)
        }
    }
    
    private mutating func drawCards(count: Int){
        for _ in 0..<count {
            let card = cardPile.popLast()
            if let card {
                displayedCards.append(card)
            }
        }
    }
    
    private mutating func replaceCards(_ cards: [Card]) {
        for card in cards {
            if let index = displayedCards.firstIndex(where: { $0.id == card.id }) {
                displayedCards.remove(at: index)
                let newCard = cardPile.popLast()
                if let newCard {
                    displayedCards.insert(newCard, at: index)
                }
            }
        }
    }
    
    private mutating func changeSelection(of cards: [Card], to selection: selectionMode) {
        for card in cards {
            if let index = displayedCards.firstIndex(where: { $0.id == card.id }) {
                displayedCards[index].selection = selection
            }
        }
    }
    
    mutating func choose(_ card: Card) {
        /// none, one or two cards are already selected; it is possible for another card to be selected; distinguish between selection and deselction
        if potentialSet.count == 2 || potentialSet.count == 1 || potentialSet.isEmpty {
            switch card.selection {
            case .none:
                potentialSet.append(card)
                changeSelection(of: [card], to: selectionMode.selected)
            default:
                potentialSet.removeAll { $0.id == card.id }
                changeSelection(of: [card], to: selectionMode.none)
            }
        } else { /// three cards are already selected
            if validSet { ///three selected cards are a valid set; pressing a card that is part of the set does nothing;
                /// pressing any other card removes the valid set and selects the new card
                switch card.selection {
                case .containedInValidSet:
                    break
                default:
                    replaceCards(potentialSet)
                    potentialSet.removeAll()
                    potentialSet.append(card)
                    changeSelection(of: [card], to: selectionMode.selected)
                    validSet = false
                }
            }
            else { /// three selected cards are an invalid set; pressing any card deselects the invalid set and selects the new card
                changeSelection(of: potentialSet, to: selectionMode.none)
                potentialSet.removeAll()
                potentialSet.append(card)
                changeSelection(of: [card], to: selectionMode.selected)
            }
        }
        /// if at this point there are three cards and no valid set yet check if these cards are a valid set
        if potentialSet.count == 3 && !validSet {
            if checkForSet() {
                print("valid set")
                validSet = true
                changeSelection(of: potentialSet, to: selectionMode.containedInValidSet)
            } else {
                print("invalid set")
                validSet = false
                changeSelection(of: potentialSet, to: selectionMode.containedInInvalidSet)
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
            return false }
        if !checkEqualityOfFeature(cardOne.color, cardTwo.color, cardThree.color) &&
            !checkUniquenessOfFeature(cardOne.color, cardTwo.color, cardThree.color) {
            return false }
        if !checkEqualityOfFeature(cardOne.shading, cardTwo.shading, cardThree.shading) &&
            !checkUniquenessOfFeature(cardOne.shading, cardTwo.shading, cardThree.shading) {
            return false }
        if !checkEqualityOfFeature(cardOne.amount, cardTwo.amount, cardThree.amount) &&
            !checkUniquenessOfFeature(cardOne.amount, cardTwo.amount, cardThree.amount) {
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
        case containedInValidSet
        case containedInInvalidSet
    }
}





