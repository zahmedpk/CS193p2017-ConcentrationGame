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
    @IBOutlet var scoreLabel: UILabel!
    
    var themes = [
        ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🥕", "🍆","🌽","🧅"],
        ["🐶", "🐱", "🐭", "🐧", "🐥", "🐝", "🐠", "🐒", "🐳", "🦈", "🐸", "🐼","🦂","🐅"],
        ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓","🏸","🏑"],
        ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🛴", "🚲", "🛵", "✈️","🚊","🚀"],
        ["⌚️", "📱", "💻", "📞", "☎️", "📟", "📠", "📺", "⏰", "🔌", "💡", "🔦","💿","📡"],
        ["🇵🇰", "🇹🇷", "🇺🇸", "🇰🇷", "🇨🇭", "🇸🇦", "🇲🇾", "🇮🇳", "🇨🇦", "🇨🇳", "🇸🇻", "🇯🇵","🇱🇧","🎌"],
    ]
    var emojis : [String]!
    var game: Concentration!
    var flipsCounter = 0
    
    func resetUI(){
        emojis = themes.randomElement()
        for cardButton in cardButtons {
            cardButton.setTitle("", for: .normal)
            cardButton.backgroundColor = .systemOrange
        }
        flipsCounter = 0
        flipsCountLabel.text = "Flips: \(flipsCounter)"
        flipsCountLabel.sizeToFit()
        scoreLabel.text = "Score: 0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(cardButtons.count % 2 == 0, "Number of cards must be even.")
        let numberOfPairs = cardButtons.count/2
        startNewGame(numberOfPairs: numberOfPairs)
    }
    func startNewGame(numberOfPairs: Int) {
        resetUI()
        assert(numberOfPairs <= emojis.count, "Number of pairs greater that number of emojis available.")
        game = Concentration(numberOfPairs: numberOfPairs)
    }
    @IBAction func cardTouched(_ sender: UIButton) {
        var touchedCard: Card!
        if let index = cardButtons.firstIndex(of: sender){
            touchedCard = game.cards[index]
            if touchedCard.isMatched {
                return
            }
            game.chooseCard(at: index)
        }
        flipsCounter += 1
        flipsCountLabel.text = "Flips: \(flipsCounter)"
        flipsCountLabel.sizeToFit()
        scoreLabel.text = "Score: \(game.score)"
        scoreLabel.sizeToFit()
        for (index, card) in game.cards.enumerated() {
            let button = cardButtons[index]
            if card.isMatched && card.identifier != touchedCard.identifier {
                // if this card just got matched with this touch
                // don't hide this pair till some other card
                // is touched
                button.setTitle("", for: .normal)
                button.backgroundColor = .clear
            } else if card.isFaceUp {
                button.setTitle(emojis[card.identifier], for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = .systemOrange
            }
        }
    }
    
    @IBAction func newGameButtonTouched(_ sender: UIButton) {
        startNewGame(numberOfPairs: cardButtons.count/2)
    }
}
