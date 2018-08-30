//
//  ViewController.swift
//  Concentration
//
//  Created by Юрий Забегаев on 16.08.2018.
//  Copyright © 2018 Юрий Забегаев. All rights reserved.
//

import UIKit

class ConcentrationVC: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (self.cards.count+1)/2)
    private var cardEmojies: [Int:String] = [:]
    var currentTheme: Theme! {
        didSet {
            updateTheme()
        }
    }
    var emojies: String = ""

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
        if currentTheme == nil {
            currentTheme = ConcentrationThemeChooserVCViewController.themes[0]
        }
        game.startNewGame()
        updateTheme()
        updateUI()
    }
    
    override func viewDidLoad() {
        startNewGame()
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
        card.backgroundColor = currentTheme.closedCardColor
        card.setTitle("", for: .normal)
    }
    
    private func openCard(atIndex index: Int) {
        let card = cards[index]
        card.backgroundColor = currentTheme.openedCardColor
        let currentCardEmoji = getCardEmoji(forID: game.cards[index].id)
        card.setTitle(currentCardEmoji, for: .normal)
    }
    
    private func getCardEmoji(forID id:Int) -> String {
        if cardEmojies[id-1] == nil {
            cardEmojies[id-1] = String(emojies[emojies.index(before: emojies.endIndex)])
            emojies = String(emojies.dropLast())
        }
        return cardEmojies[id-1]!
    }
    
    private func updateTheme() {
        if cards != nil {
            for index in cards.indices {
                if game.cards[index].isOpen || game.cards[index].isCompleted {
                    openCard(atIndex: index)
                } else {
                    closeCard(atIndex: index)
                }
            }
        }
        emojies = currentTheme.emojiPack
        self.view.backgroundColor = currentTheme.backgroundColor
        newGameButton.setTitleColor(currentTheme.textColor,
                                    for: .normal)
        scoreLabel.textColor = currentTheme.textColor
        flipCounterLabel.textColor = currentTheme.textColor
    }
}
