//
//  Concentration.swift
//  Concetration
//
//  Created by  R2D2 on 13.04.2018.
//  Copyright © 2018  R2D2. All rights reserved.
//

import Foundation
class Concentration
{
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for i in cards.indices {
                if cards[i].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = i
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard (index: Int) {
        assert(cards.indices.contains(index), "Concentration.choosesCard(at:\(index): choosen index is not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                indexOfOneAndOnlyFaceUpCard = index
            } else {
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    init(numberOfPairsOfCard: Int) {
        assert(numberOfPairsOfCard > 0, "Concentration init ( \(numberOfPairsOfCard)): you must have at least one pairs of cards")
        for _ in 1...numberOfPairsOfCard{
            let card = Card()
            cards += [card, card]
        }
    }
}
