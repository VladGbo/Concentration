//
//  ViewController.swift
//  Concetration
//
//  Created by  R2D2 on 11.04.2018.
//  Copyright © 2018  R2D2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var game = Concentration(numberOfPairsOfCard: numberOfPairsOfCard)
    
    
    var numberOfPairsOfCard: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private var emojiChoice = ["👻", "🎃", "🐛", "🦑", "☃️", "🕷", "🦇", "🐺", "🐍"]
    
    private var emoji = [Int: String]()
    
    private(set) var flipCount = 0 {
        didSet{
            flipCountLabel.text! = "Flips: \(flipCount)"
        }
    }
    

    @IBAction private func touchButton(_ sender: UIButton){
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(index: cardNumber)
            updateViewFromModel()
        }
        flipCount += 1
    }
    
    
    private func updateViewFromModel (){
        for index in cardButtons.indices{
            let card = game.cards[index]
            let button = cardButtons[index]
            
            if card.isFaceUp{
                button.setTitle(emoji (for:card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private func emoji (for card: Card) -> String {
        if emojiChoice.count > 0, emoji[card.identifier] == nil {
            emoji[card.identifier] = emojiChoice.remove(at: emojiChoice.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

