//
//  ViewController.swift
//  Concentration
//
//  Created by Юрий Забегаев on 16.08.2018.
//  Copyright © 2018 Юрий Забегаев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (self.cards.count+1)/2)
    var emojiArray:[String]!
    private var cardEmojies : [Int:String] = [:]
    var currentTheme: ColorTheme!

    @IBOutlet var cards: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCounterLabel: UILabel!
    
    @IBAction func cardIsTapped(_ sender: UIButton) {
        let senderIndex = cards.index(of: sender)!
        game.openCard(withIndex: senderIndex)
        updateUI()
    }
    
    @IBAction func startNewGame() {
        game.startNewGame()
        setNewTheme()
        updateUI()
    }
    
    override func viewDidLoad() {
        setNewTheme()
        updateUI()
    }
    
    private func updateUI() {
        for index in cards.indices {
            if game.cards[index].isOpen || game.cards[index].isCompleted {
                openCard(atIndex: index)
            } else {
                closeCard(atIndex: index)
            }
        }
        if game.isFinished {
            newGameButton.isHidden = false
        } else {
            newGameButton.isHidden = true
        }
        scoreLabel.text = "Score: \(game.playerScore)"
        flipCounterLabel.text = "Flips: \(game.flipCounter)"
    }
    
    private func closeCard(atIndex index: Int) {
        let card = cards[index]
        card.backgroundColor = currentTheme.colors.closedCardColor
        card.setTitle("", for: .normal)
    }
    
    private func openCard(atIndex index: Int) {
        let card = cards[index]
        card.backgroundColor = currentTheme.colors.openedCardColor
        let currentCardEmoji = getCardEmoji(forID: game.cards[index].id)
        card.setTitle(currentCardEmoji, for: .normal)
    }
    
    private func getCardEmoji(forID id:Int) -> String {
        if cardEmojies[id-1] == nil {
            cardEmojies[id-1] = emojiArray.popLast()!
        }
        return cardEmojies[id-1]!
    }
    
    private func setNewTheme() {
        currentTheme = ColorTheme.random()
        
        self.view.backgroundColor = currentTheme.colors.backgroundColor
        emojiArray = currentTheme.colors.emojiPack
        newGameButton.setTitleColor(currentTheme.colors.textColor,
                                    for: .normal)
        scoreLabel.textColor = currentTheme.colors.textColor
        flipCounterLabel.textColor = currentTheme.colors.textColor
    }
}
