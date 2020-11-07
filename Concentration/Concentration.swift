//
//  Game.swift
//  Concentration
//
//  Created by Zubair Ahmed on 06/11/2020.
//  Copyright © 2020 Zubair Ahmed. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var singleCardFacingUpAt: Int?
    func addACardPair(withIdentifier identifier: Int){
        cards += [Card(identifier: identifier), Card(identifier: identifier)]
    }
    func chooseCard(at index: Int){
        let chosenCard = cards[index]
        if chosenCard.isFaceUp || chosenCard.isMatched {
            return
        }
        if let index2 = singleCardFacingUpAt {
            let card2 = cards[index2]
            if chosenCard.identifier == card2.identifier {
                chosenCard.isMatched = true
                card2.isMatched = true
            }
            singleCardFacingUpAt = nil
            chosenCard.isFaceUp = true
        } else {
            for card in cards {
                card.isFaceUp = false
            }
            singleCardFacingUpAt = index
            chosenCard.isFaceUp = true
        }
    }
    init(numberOfPairs: Int) {
        for identifier in 0..<numberOfPairs {
            let newCard = Card(identifier: identifier)
            let newCard2 = Card(identifier: identifier)
            cards.append(newCard)
            cards.append(newCard2)
        }
    }
}
