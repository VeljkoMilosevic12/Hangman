//
//  String+Extensions.swift
//  Hangman
//
//  Created by Veljko Milosevic on 28/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation

extension String {
    
    func findCharactersIndex(character:Character) -> [Int] {
        var empty = [Int]()
        for i in self.enumerated() {
            if i.element == character {
                empty.append(i.offset)
            }
        }
        return empty
    }
    
    subscript(index: Int) -> Character {
        get {
            return Array(self)[index]
        }
        set(newValue) {
            var temp = Array(self)
            temp[index] = newValue
            self = String(temp)
        }
    }
}
