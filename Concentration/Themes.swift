//
//  Themes.swift
//  Concentration
//
//  Created by Юрий Забегаев on 16.08.2018.
//  Copyright © 2018 Юрий Забегаев. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    var backgroundColor: UIColor
    var textColor: UIColor
    
    var openedCardColor: UIColor
    var closedCardColor: UIColor
    
    var emojiPack : [String]
}

let darkTheme = Theme(backgroundColor: .black,
                      textColor: .white,
                      openedCardColor: .blue,
                      closedCardColor: .darkGray,
                      emojiPack: ["⚽️", "🏐", "🏀", "🏉", "⚾️", "🥊", "🏆", "🎲"])
let lightTheme = Theme(backgroundColor: .white,
                       textColor: .black,
                       openedCardColor: .white,
                       closedCardColor: .blue,
                       emojiPack: ["🐶", "🦋", "🐧", "🐞", "🐠", "🐒", "🐤", "🐌"])
let halloweenTheme = Theme(backgroundColor: .black,
                           textColor: .orange,
                           openedCardColor: .white,
                           closedCardColor: .orange,
                           emojiPack: ["☠️", "👿", "😾", "👻", "👹", "👽", "👾", "💩"])
let prettyTheme = Theme(backgroundColor: .cyan,
                        textColor: .black,
                        openedCardColor: .magenta,
                        closedCardColor: .white,
                        emojiPack: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑"])



enum ColorTheme: UInt32 {
    case dark, light, pretty, halloween

    var colors: Theme {
        switch self {
        case .dark:
            return darkTheme
        case .light:
            return lightTheme
        case .pretty:
            return prettyTheme
        case .halloween:
            return halloweenTheme
        }
    }
    
    static func random() -> ColorTheme {
        // Update as new enumerations are added
        let maxValue = halloween.rawValue
        
        let rand = arc4random_uniform(maxValue+1)
        return ColorTheme(rawValue: rand)!
    }
}
