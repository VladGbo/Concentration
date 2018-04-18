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
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard (index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
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
        for _ in 1...numberOfPairsOfCard{
            let card = Card()
            cards += [card, card]
        }
    }
}
