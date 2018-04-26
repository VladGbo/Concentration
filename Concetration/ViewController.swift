//
//  ViewController.swift
//  Concetration
//
//  Created by  R2D2 on 11.04.2018.
//  Copyright © 2018  R2D2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var gameScore: UILabel!
    
    lazy var game = Concentration(numberOfPairsOfCard: (cardButtons.count + 1) / 2)
    
    let emojiThemes = [["😀", "🤯", "😱", "🤪", "😇", "🤩", "🤬", "😘", "🤓"],
                       ["😈", "👹", "👺", "👻", "☠️", "💀","👽", "👾", "🎃"],
                       ["🤲", "👐", "👊", "🤟", "🖖", "🤙","👌", "🤞", "👇"],
                       ["💂‍♀️", "👩‍🌾", "👮‍♂️", "👨‍🚒", "🎅", "👩‍✈️","👨‍🎤", "🧝‍♂️", "🧙‍♀️"],
                       ["🦑", "🐙", "🦐", "🦀", "🐡", "🐠","🐟", "🐬", "🐳"],
                       ["🐝", "🐛", "🦋", "🐌", "🐜", "🐞","🦗", "🕷", "🦂"]]
    
    lazy var themeEmoji = Theme(themesOfGame: emojiThemes)
    
    lazy var emojiChoice = themeEmoji.randomEmoji()
    
    var emoji = [Int: String]()
        

    @IBAction func touchButton(_ sender: UIButton){
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(index: cardNumber)
            updateViewFromModel()
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        gameScore.text = "Score: \(game.score)"
    }
    
    func updateViewFromModel () {
        
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
    
    
    func emoji (for card: Card) -> String {
        if emojiChoice.count > 0, emoji[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoice.count)))
            emoji[card.identifier] = emojiChoice.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func newGameConcentration(_ sender: UIButton){
        game.resetGame()
        flipCountLabel.text = "Score: 0"
        gameScore.text = "Score: 0"
        self.emojiChoice.removeAll()
        self.emoji.removeAll()
        self.emojiChoice = themeEmoji.randomEmoji()
        updateViewFromModel()
        print(emojiChoice)
    }

}

