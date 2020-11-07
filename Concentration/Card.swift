//
//  Card.swift
//  Concentration
//
//  Created by Zubair Ahmed on 06/11/2020.
//  Copyright © 2020 Zubair Ahmed. All rights reserved.
//

import Foundation

class Card: CustomStringConvertible {
    var identifier: Int
    var isFaceUp = false
    var isMatched = false
    var seen = false
    init(identifier: Int) {
        self.identifier = identifier
    }
    var description: String {
        return "Card id:\(identifier),isFaceUp:\(isFaceUp), isMatched:\(isMatched)"
    }
}
