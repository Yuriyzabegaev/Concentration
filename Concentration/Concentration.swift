//
//  Concentration.swift
//  Concentration
//
//  Created by Юрий Забегаев on 16.08.2018.
//  Copyright © 2018 Юрий Забегаев. All rights reserved.
//

import Foundation


struct Card {
    var isOpen = false {
        didSet {
            if isOpen == true {
                isSeenBefore = true
            }
        }
    }
    var isCompleted = false
    var isSeenBefore = false
    let id: Int
    
    static var idFactory = 0
    
    static func makeUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
    
    init() {
        id = Card.makeUniqueId()
    }
}

class Concentration {
    var cards:[Card] = []
    var openedOneAndOnlyOneCardIndex :Int?
    var numberOfPairsOfCards :Int
    var isFinished = false
    var completedPairs = 0
    var flipCounter = 0
    var lastFlipDate:Date?
    var playerScore = 0 {
        didSet {
            if playerScore < 0 {
                playerScore = 0
            }
        }
    }
    let scoreIncrease = 2
    let scoreDecrease = 1
    let secondsToBonus = 3
    let bonus = 1
    
    init(numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        startNewGame()
    }
    
    func startNewGame() {
        playerScore = 0
        Card.idFactory = 0
        completedPairs = 0
        flipCounter = 0
        cards = []
        openedOneAndOnlyOneCardIndex = nil
        for _ in 0..<numberOfPairsOfCards {
            let newCard = Card()
            cards += [newCard, newCard]
        }
        shuffleCards()
        isFinished = false
    }
    
    func openCard(withIndex index: Int) {
        assert(index < cards.count)
        
        guard !isFinished else {
            return
        }
        
        guard !cards[index].isOpen, !cards[index].isCompleted else {
            return
        }
        
        flipCounter += 1
        
        if openedOneAndOnlyOneCardIndex != nil {
            /// player opens second card
            
            if cards[openedOneAndOnlyOneCardIndex!].id == cards[index].id {
            /// player guesses second card correctly
                cards[openedOneAndOnlyOneCardIndex!].isCompleted = true
                cards[index].isCompleted = true
                completedPairs += 1
                
                let previousFlipDate = self.lastFlipDate ?? Date(timeIntervalSinceReferenceDate: 0)
                if -previousFlipDate.timeIntervalSinceNow < TimeInterval(secondsToBonus) {
                    playerScore += scoreIncrease + bonus
                } else {
                    playerScore += scoreIncrease
                }
                if completedPairs >= numberOfPairsOfCards {
                    isFinished = true
                }
            } else {
            /// player didn't guess second card correctly
                if cards[index].isSeenBefore == true {
                    playerScore -= scoreDecrease
                }
            }
            
            openedOneAndOnlyOneCardIndex = nil
        } else {
            /// player opens first card
            if cards[index].isSeenBefore == true {
                playerScore -= scoreDecrease
            }
            for index in cards.indices {
                cards[index].isOpen = false
            }
            openedOneAndOnlyOneCardIndex = index
        }
        lastFlipDate = Date()
        cards[index].isOpen = true
    }
    
    private func shuffleCards() {
        for index in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
//            swap(&cards[index], &cards[randomIndex])
            let swapPlace = cards[index]
            cards[index] = cards[randomIndex]
            cards[randomIndex] = swapPlace
        }
    }
}
