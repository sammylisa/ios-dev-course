//
//  ViewController.swift
//  Concentration
//
//  Created by Samuel Lisa on 5/11/20.
//  Copyright © 2020 Samuel Lisa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    if let cardIndex = cardButtons.firstIndex(of: sender) {
        flipCard(withEmoji: emojiChoices[cardIndex], on: sender)
    } else {
    print("card not found")
    }
}

func flipCard(withEmoji emoji: String, on button: UIButton) {
    if button.currentTitle == emoji {
        button.setTitle("", for: UIControl.State.normal)
        button.backgroundColor =  colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    } else {
        button.setTitle(emoji, for: UIControl.State.normal)
        button.backgroundColor =  colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}
}
    var emojiChoices = ["⛄️", "🥞", "🌶"]
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {

