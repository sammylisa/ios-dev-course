//
//  ViewController.swift
//  Concentration
//
//  Created by Samuel Lisa on 5/11/20.
//  Copyright © 2020 Samuel Lisa. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var foodEmoji = ["🌽", "🥞", "🌶", "🍑", "🍩", "🍕", "🥨", "🍌", "🥥", "🧀", "🍗"]
    var faceEmoji = ["😀", "🧐", "🥶", "🥺", "🤓", "😷", "🤠", "😑", "🤯", "😩", "😫"]
    var flagEmoji = ["🇱🇷", "🇩🇪", "🇨🇺", "🇮🇱", "🇺🇾", "🇻🇳", "🇮🇹", "🇨🇮", "🇦🇹", "🇰🇵", "🇵🇱"]
    var sportEmoji = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🏓"]
    var animalEmoji = ["🐶", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🦁", "🐷", "🐸"]
    var natureEmoji = ["🌵", "🌳", "🌴", "🍄", "🌸", "🌻", "🍁", "🌱", "🐚", "🌞", "🌝"]

    lazy var emojiGroups = [foodEmoji, faceEmoji, flagEmoji, sportEmoji, animalEmoji, natureEmoji]
    lazy var selectedEmoji = emojiGroups.randomElement()!
    
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
            let randomIndex = Int(arc4random_uniform(UInt32(selectedEmoji.count)))
            emoji[card.identifier] = selectedEmoji.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
