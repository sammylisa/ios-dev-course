//
//  Concentration.swift
//  Concentration
//
//  Created by Samuel Lisa on 5/12/20.
//  Copyright © 2020 Samuel Lisa. All rights reserved.
//

import Foundation

class Concentration {

    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var score = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    score += 2
                } else {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func reset() {
        score = 0
        for cardIndex in cards.indices {
            cards[cardIndex].isFaceUp = false
            cards[cardIndex].isMatched = false
            indexOfOneAndOnlyFaceUpCard = nil
        }
    }
    
    func randomize() {
        for _ in 0..<cards.count {
            let card = cards.removeFirst()
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.insert(card, at: randomIndex)
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        randomize()
    }
}
