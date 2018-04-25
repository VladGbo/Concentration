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
    
    let getPoints = Score()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var wasPickedCards = [Int]()
    
    var score = 0
    
    func chooseCard (index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    wasPickedCards.append(index)
                    score += getPoints.addPoint
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                } else {
                    if !isAppendUsedIndexCard(for: index){
                        if score < 1{
                            score = 0
                        } else {
                        score -= getPoints.pointPenalty
                        }
                    }
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
        for _ in 1...numberOfPairsOfCard {
            let card = Card()
            cards += [card, card]
        }
        self.cards = shuffleTheCards(for: cards)
    }
    
    
    func shuffleTheCards ( for cards: [Card]) -> [Card] {
        var shuffleCards = cards
        var newArr = [Card]()
        for _ in cards.indices{
            newArr.append(shuffleCards.remove(at: Int(arc4random_uniform(UInt32(shuffleCards.count)))))
        }
        return newArr
    }
    
    func resetGame () {
        for card in cards.indices {
            cards[card].isMatched = false
            cards[card].isFaceUp = false
        }
        self.cards = shuffleTheCards(for: cards)
    }
    
    
    func isAppendUsedIndexCard(for cardIndex: Int) -> Bool{
        if wasPickedCards.isEmpty{
            wasPickedCards.append(cardIndex)
            return true
        } else {
            for index in wasPickedCards.indices {
                if wasPickedCards[index] == cardIndex{
                    return false
                } else {
                    continue
                }
            }
            wasPickedCards.append(cardIndex)
            return true
        }
    }
}
