//
//  Card.swift
//  Concentration
//
//  Created by Samuel Lisa on 5/12/20.
//  Copyright © 2020 Samuel Lisa. All rights reserved.
//

import Foundation

struct Card {

    var isFaceUp = false;
    var isMatched = false;
    var identifier: Int
    
    static var identifierFactory = 0;
    
    static func createUniqueID() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.createUniqueID()
    }
}
