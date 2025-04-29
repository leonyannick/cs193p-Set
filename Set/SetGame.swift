//
//  SetGame.swift
//  Set
//
//  Created by Leon Baumann on 07.04.25.
//

import Foundation

struct SetGame {
    private(set) var cards: [Card] = []
    
    var testCard = Card(shape: Feature.two, color: Feature.one, shading: Feature.three, amount: Feature.three)
    
    init() {
        for shape in Feature.allCases {
            for color in Feature.allCases {
                for shading in Feature.allCases {
                    for amount in Feature.allCases {
                        cards.append(Card(
                            shape: shape,
                            color: color,
                            shading: shading,
                            amount: amount
                        ))
                    }
                }
            }
        }
    }
    
    struct Card: Identifiable, Equatable, CustomDebugStringConvertible {
        var id = UUID()
        
        let shape: Feature
        let color: Feature
        let shading: Feature
        let amount: Feature
        
        var debugDescription: String { "[\(shape), \(color), \(shading), \(amount)]" }
    }
    
    enum Feature: Int, CaseIterable {
        case one = 1, two, three
    }
}





