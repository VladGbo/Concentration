//
//  Theme.swift
//  Concetration
//
//  Created by  R2D2 on 21.04.2018.
//  Copyright © 2018  R2D2. All rights reserved.
//

import Foundation


class Theme {
    
    
    var themesOfGame = [[String]]()
    
    init(themesOfGame: [[String]]) {
        self.themesOfGame = themesOfGame
    }
    
    func randomEmoji () -> [String]{
        return themesOfGame[Int(arc4random_uniform(UInt32(themesOfGame.count)))]
    }
}
