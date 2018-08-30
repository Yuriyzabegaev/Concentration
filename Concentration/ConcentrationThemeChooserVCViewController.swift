//
//  ConcentrationThemeChooserVCViewController.swift
//  Concentration
//
//  Created by Юрий Забегаев on 31.08.2018.
//  Copyright © 2018 Юрий Забегаев. All rights reserved.
//

import UIKit


struct Theme {
    let name: String
    
    let backgroundColor: UIColor
    let textColor: UIColor
    
    let openedCardColor: UIColor
    let closedCardColor: UIColor
    
    let emojiPack : String
}


class ConcentrationThemeChooserVCViewController: UIViewController {

    
    static let themes = [
        Theme(name: "darkTheme",
              backgroundColor: .black,
              textColor: .white,
              openedCardColor: .blue,
              closedCardColor: .darkGray,
              emojiPack: "⚽️🏐🏀🏉⚾️🥊🏆🎲"),
        Theme(name: "lightTheme",
              backgroundColor: .white,
              textColor: .black,
              openedCardColor: .white,
              closedCardColor: .blue,
              emojiPack: "🐶🦋🐧🐞🐠🐒🐤🐌"),
        Theme(name: "halloweenTheme",
              backgroundColor: .black,
              textColor: .orange,
              openedCardColor: .white,
              closedCardColor: .orange,
              emojiPack: "☠️👿😾👻👹👽👾💩"),
        Theme(name: "prettyTheme",
            backgroundColor: .cyan,
            textColor: .black,
            openedCardColor: .magenta,
            closedCardColor: .white,
            emojiPack: "🚗🚕🚙🚌🚎🏎🚓🚑")
    ]
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cvc = segue.destination as? ConcentrationVC {
            if let button = sender as? UIButton {
                let theme = ConcentrationThemeChooserVCViewController.themes[button.tag - 1]
                cvc.currentTheme = theme
            }
        }
    }

}
