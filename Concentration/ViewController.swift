//
//  ViewController.swift
//  Concentration
//
//  Created by Zubair Ahmed on 06/11/2020.
//  Copyright © 2020 Zubair Ahmed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet var flipsCountLabel: UILabel!
    @IBOutlet var newGameButton: UIButton!
    
    var emojis = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🥕", "🍆","🌽","🧅"]
    var emojiForIdentifier = [Int:String]()
    var game: Game!
    var flipsCounter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        for cardButton in cardButtons {
            cardButton.setTitle("", for: .normal)
            cardButton.backgroundColor = .systemOrange
        }
        assert(cardButtons.count % 2 == 0, "Number of cards must be even.")
        let numberOfPairs = cardButtons.count/2
        assert(numberOfPairs <= emojis.count, "Number of pairs greater that number of emojis.")
        setUpNewGame(numberOfPairs: numberOfPairs)
    }
    func setUpNewGame(numberOfPairs: Int) {
        let newGame = Game()
        var emojisCopy = emojis
        emojiForIdentifier.removeAll()
        for identifier in 1...numberOfPairs {
            let emoji = emojisCopy.first!
            newGame.addACardPair(withIdentifier: identifier)
            emojiForIdentifier[identifier] = emoji
            emojisCopy.remove(at: 0)
        }
        game = newGame
    }
    @IBAction func cardTouched(_ sender: UIButton) {
        flipsCounter += 1
        flipsCountLabel.text = "Flips: \(flipsCounter)"
        flipsCountLabel.sizeToFit()
        var touchedCard: Card!
        if let index = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: index)
            touchedCard = game.cards[index]
        }
        for (index, card) in game.cards.enumerated() {
            let button = cardButtons[index]
            if card.isMatched && card.identifier != touchedCard.identifier {
                // if this card just got matched with this touch
                // don't hide this pair till some other card
                // is touched
                button.setTitle("", for: .normal)
                button.backgroundColor = .clear
            } else if card.isFaceUp {
                button.setTitle(emojiForIdentifier[card.identifier], for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = .systemOrange
            }
        }
    }
    
    @IBAction func newGameButtonTouched(_ sender: UIButton) {
        let numberOfPairs = cardButtons.count/2
        setUpNewGame(numberOfPairs: numberOfPairs)
        for cardButton in cardButtons {
            cardButton.setTitle("", for: .normal)
            cardButton.backgroundColor = .systemOrange
        }
    }
}
