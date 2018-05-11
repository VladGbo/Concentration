//
//  Card.swift
//  Concetration
//
//  Created by  R2D2 on 14.04.2018.
//  Copyright © 2018  R2D2. All rights reserved.
//

import Foundation
struct Card
{
    
    private static var identifierFactory = 0
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static func getUniqueIdentififer () -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentififer()
    }
}
