//
//  SetGame.swift
//  Set
//
//  Created by Leon Baumann on 07.04.25.
//

import Foundation

struct SetGame<CardContent: Equatable> {
    private(set) var cards: [Card]
    private let numberOfCards = 81
    
    init(makeCardContent: () -> CardContent) {
        for index in 0..<numberOfCards {
            cards.append(Card(id: "\(index)", content: makeCardContent()))
        }
    }
    
    struct Card: Identifiable, Equatable {
        var id: String
        
        enum featureOne { case one, two, three }
        enum featureTwo { case one, two, three }
        enum featureThree { case one, two, three }
    }
    
}





