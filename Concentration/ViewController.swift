//
//  ViewController.swift
//  Concentration
//
//  Created by Samuel Lisa on 5/11/20.
//  Copyright © 2020 Samuel Lisa. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
        
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    private var foodEmoji = ["🌽", "🥞", "🌶", "🍑", "🍩", "🍕", "🥨", "🍌", "🥥", "🧀", "🍗"]
    private var faceEmoji = ["😀", "🧐", "🥶", "🥺", "🤓", "😷", "🤠", "😑", "🤯", "😩", "😫"]
    private var flagEmoji = ["🇱🇷", "🇩🇪", "🇨🇺", "🇮🇱", "🇺🇾", "🇻🇳", "🇮🇹", "🇨🇮", "🇦🇹", "🇰🇵", "🇵🇱"]
    private var sportEmoji = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓"]
    private var animalEmoji = ["🐶", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🦁", "🐷", "🐸"]
    private var natureEmoji = ["🌵", "🌳", "🌴", "🍄", "🌸", "🌻", "🍁", "🌱", "🐚", "🌞", "🌝"]

    private lazy var emojiGroups = [foodEmoji, faceEmoji, flagEmoji, sportEmoji, animalEmoji, natureEmoji]
    private lazy var selectedEmoji = emojiGroups.randomElement()!
    
    @IBAction func newGame(_ sender: UIButton) {
        game.reset()
        pickNewEmoji()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("card not found")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Score: \(game.score)"
    }
    
    func pickNewEmoji() {
        selectedEmoji = emojiGroups.randomElement()!
    }
    
    var emoji = [Int : String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, selectedEmoji.count > 0 {
            emoji[card.identifier] = selectedEmoji.remove(at: selectedEmoji.count.arc4random)
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
