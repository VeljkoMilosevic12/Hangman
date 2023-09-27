//
//  Label+Extensions.swift
//  Hangman
//
//  Created by Veljko Milosevic on 11.5.21..
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit

extension UILabel {
    func addCharacterSpacing(kernValue: Double = 4.15, custom:Double) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue * custom, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
