//
//  MultiplayerViewModel.swift
//  Hangman
//
//  Created by Veljko Milosevic on 30/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation


class MultiplayerViewModel {
    
    var guessingWord = ""
    var delegate: ModeDelegate?
    private var goodLetterPressed = 0
    private var badLetterPressed = 0
    private var audioService = AudioService()
    
    private var guessingWordHidden: String  {
        get {
        return guessingWord.replacingOccurrences(of: "[a-z,A-Z]", with: "-", options: [.regularExpression])
        }
       
    }
    
     var result:String  = ""
    
    func checkPressedLetter(_ letter: Character, handler: @escaping (Int) -> Void) {
        
        if guessingWord.uppercased().contains(letter) {
            let indexes = guessingWord.findCharactersIndex(character: letter)
            indexes.forEach({result[$0] = letter})

            goodLetterPressed += 1
            self.audioService.playSound(sound: .win)
        }
        else {
            handler(badLetterPressed)
            badLetterPressed += 1
            self.audioService.playSound(sound: .lose)
        }
        checkWinOrLose()
    }
    
    func setupWord(word:String?) {
        guard let word = word else {
            print("nil je ne znam zasto")
            return}
        guessingWord = word
        result = guessingWordHidden
        
    }
    
    
    private func resetCounters() {
        goodLetterPressed = 0
        badLetterPressed = 0
    }
    
    private var guessingWordUniqueCount : Int {
        var set = Set<Character>()
        return guessingWord.filter{ set.insert($0).inserted && $0 != " "}.count
    }
    
    
    private func checkWinOrLose() {
        
        if goodLetterPressed == guessingWordUniqueCount && badLetterPressed < 7 {
            resetCounters()
            delegate?.gameWon(guessingWord)
        }
        else if badLetterPressed == 7 && goodLetterPressed < guessingWordUniqueCount {
            resetCounters()
            delegate?.gameLost(guessingWord)
        }
        
    }
    
   
}



