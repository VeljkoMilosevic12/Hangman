//
//  NormalGameViewModel.swift
//  Hangman
//
//  Created by Veljko Milosevic on 27/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation
import UIKit

protocol Strategy {
    var result:String {get set}
    func checkPressedLetter(_ letter: Character, handler: @escaping (Int) -> Void)
    func setupQuestion(handler: (() -> Void)?)
    var guessingWord:String! { get set }
    var title:String {get}
    
}

protocol ModeDelegate {
    func gameWon(_ currentWord:String)
    func gameLost(_ currentWord:String)
    func passedAll()
}




class NormalGameViewModel: Strategy {
    
    var delegate: ModeDelegate?
    private var goodLetterPressed = 0
    private var badLetterPressed = 0
    var guessingWord: String!
    private var audioService = AudioService()
    
    private var normalModeVM:SelectCategoryViewModel!
    
    init(selectCategoryVM:SelectCategoryViewModel) {
        normalModeVM = selectCategoryVM
    }
    
    private var guessingWordHidden: String {
        get {
            return guessingWord.replacingOccurrences(of: "[a-z,A-Z]", with: "-", options: [.regularExpression])
        }
        set {
            result = newValue
        }
    }
    
    var result:String = ""
    
    
    private var guessingWordUniqueCount : Int {
        var set = Set<Character>()
        return guessingWord.filter{ set.insert($0).inserted && $0 != " "}.count
    }
    
    
    func checkPressedLetter(_ letter: Character, handler: @escaping (Int) -> Void) {
        
        if guessingWord.contains(letter) {
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
    
    
    func setupQuestion(handler: (() -> Void)?) {
        guard let guessingWord = normalModeVM.guessingWords.randomElement()?.title.uppercased() else {
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
            normalModeVM.guessingWords.removeAll(where: {$0.title == guessingWord})
          //  saveWin()
            delegate?.gameWon(guessingWord)
        }
        else if badLetterPressed == 7 && goodLetterPressed < guessingWordUniqueCount {
           // saveLose()
            delegate?.gameLost(guessingWord)
        }
        
    }
    
}

extension NormalGameViewModel {
    var title: String {
        return normalModeVM.categoryName
    }
    
//    private func saveWin() {
//        StatisticServices.shared.wonGamesIncrement()
//    }
//
//    private func saveLose() {
//        StatisticServices.shared.lostGamesIncrement()
//    }
}








