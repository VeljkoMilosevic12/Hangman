//
//  GuessingCategory.swift
//  Hangman
//
//  Created by Veljko Milosevic on 27/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation

struct GuessingCategory:Codable {
    var name:String
    var image:String
    var words:[GuessingWord]
}
