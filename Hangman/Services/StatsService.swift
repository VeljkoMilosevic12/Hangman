//
//  StatsServices.swift
//  Hangman
//
//  Created by Veljko Milosevic on 09/05/2020.
//  Copyright © 2020 Veljko Milosevic. All rights reserved.
//

import Foundation

class StatsService {
    
   private enum DefaultsKeys:String {
        case allGames = "all games"
        case wonGames = "won games"
        case lostGames = "lost games"
    }
    
    static let shared = StatsService()
    
    init() {
        loadStats()
    }
    private var userDefaults = UserDefaults.standard
    
    var allGamesNum = 0
    var wonGames = 0
    var lostGames = 0
    
    func allGamesIncrement(){
        allGamesNum += 1
    }
    
    func wonGamesIncrement(){
        wonGames += 1
        allGamesIncrement()
    }
    
    func lostGamesIncrement(){
        lostGames += 1
        allGamesIncrement()
    }
    
    func clear(){
        allGamesNum = 0
        wonGames = 0
        lostGames = 0
        saveStats()
    }
    
    func saveStats() {
        userDefaults.setValue(allGamesNum, forKey: DefaultsKeys.allGames.rawValue)
        userDefaults.setValue(wonGames, forKey: DefaultsKeys.wonGames.rawValue)
        userDefaults.setValue(lostGames, forKey: DefaultsKeys.lostGames.rawValue)
    }
    
    func loadStats() {
        guard let allGames = userDefaults.value(forKey: DefaultsKeys.allGames.rawValue) as? Int,
            let wonGames = userDefaults.value(forKey: DefaultsKeys.wonGames.rawValue) as? Int,let lostGames = userDefaults.value(forKey: DefaultsKeys.lostGames.rawValue) as? Int else {return}
        self.allGamesNum = allGames
        self.wonGames = wonGames
        self.lostGames = lostGames
        
    }
    
}
