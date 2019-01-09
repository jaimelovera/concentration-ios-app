//
//  File.swift
//  Concentration
//
//  Created by Jaime Lovera on 12/10/18.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numOfPairOfCards: ((cardButtons.count + 1) / 2))
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var bestScore = -1 {
        didSet{
        bestScoreLabel.text = "Best Score: \(bestScore)"
        }
    }
    
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            if !game.cards[cardNumber].isFaceUp  {
                flipCount += 1
            }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojiChoices =  ["🎱","🍺","🍕","🍆","💩","👅","🐙","🐒","🍄"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func restartGame(_ sender: UIButton) {
        restartGame()
    }
    func restartGame() {
        for index in cardButtons.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
        //TODO: best score only updates when game complete
        if flipCount < bestScore, bestScore != -1 {
            bestScore = flipCount
        } else if bestScore == -1 {
            bestScore = flipCount
        }
        
        flipCount = 0
        game.indexOfOneAndOnlyFaceUpCard = nil
        game.cards.shuffle()
        updateViewFromModel()
    }
    
}

