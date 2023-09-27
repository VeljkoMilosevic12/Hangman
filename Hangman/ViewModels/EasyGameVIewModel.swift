//
//  EasyGameVIewModel.swift
//  Hangman
//
//  Created by Veljko Milosevic on 28/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation


class EasyGameViewModel:Strategy {
    
    var delegate: ModeDelegate?
    private var goodLetterPressed = 0
    private var badLetterPressed = 0
    var guessingWord: String!
    let audio = AudioService()
    
    private var easyModeVM:SelectCategoryViewModel!
    
    init(selectCategoryVM:SelectCategoryViewModel) {
        easyModeVM = selectCategoryVM
        
    }
    
    var guessingWordHidden: String {
        get {
            var ges = guessingWord.replacingOccurrences(of: "[a-z,A-Z]", with: "-", options: [.regularExpression])
            let rand = guessingWord.randomElement()!
            let pozicije = guessingWord.findCharactersIndex(character: rand)
            pozicije.forEach { (br) in
                ges[br] = rand
            }
            return ges
        }
        set {
            result = newValue
        }
    }
    
    var result:String = ""
    
    
    var guessingWordUniqueCount : Int {
        var set = Set<Character>()
        return guessingWord.filter{ set.insert($0).inserted && $0 != " "}.count - 1
    }
    
    func checkPressedLetter(_ letter: Character, handler: @escaping (Int) -> Void) {
        
        if guessingWord.contains(letter) {
            let indexes = guessingWord.findCharactersIndex(character: letter)
            indexes.forEach({result[$0] = letter})
            goodLetterPressed += 1
            audio.playSound(sound: .win)
        }
        else {
            handler(badLetterPressed)
            badLetterPressed += 1
            audio.playSound(sound: .lose)
        }
        checkWinOrLose()
        
    }
    
    func setupQuestion(handler: (() -> Void)?) {
        guard let guessingWord = easyModeVM.guessingWords.randomElement()?.title.uppercased() else {
            delegate?.passedAll()
            return}
        
        self.guessingWord = guessingWord
        self.result = guessingWordHidden
        resetCounters()
        handler?()
        
    }
    
    private func resetCounters() {
        goodLetterPressed = 0
        badLetterPressed = 0
    }
    
    private func checkWinOrLose() {
        
        if goodLetterPressed == guessingWordUniqueCount && badLetterPressed < 7 {
            easyModeVM.guessingWords.removeAll(where: {$0.title == guessingWord})
           // saveWin()
            delegate?.gameWon(guessingWord)
        }
            
        else if badLetterPressed == 7 && goodLetterPressed < guessingWordUniqueCount {
           // saveLose()
            delegate?.gameLost(guessingWord)
        }
        
    }
    
    
}


extension EasyGameViewModel {
    var title: String {
        return easyModeVM.categoryName
    }
    
//    private func saveWin() {
//        StatisticServices.shared.wonGamesIncrement()
//    }
//
//    private func saveLose() {
//        StatisticServices.shared.lostGamesIncrement()
//    }
}


