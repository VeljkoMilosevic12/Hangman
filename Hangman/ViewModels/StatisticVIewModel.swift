//
//  StatisticVIewModel.swift
//  Hangman
//
//  Created by Veljko Milosevic on 28/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation


class StatisticVIewModel {
    
    
    private let statsService = StatsService.shared
    
    var allGames : Int {
        return statsService.allGamesNum
    }
    
    var wonGames : Int {
        return statsService.wonGames
    }
    
    var lostGames: Int {
        return statsService.lostGames
    }
    
    var wonPercentage : Double {
       return (Double(wonGames) / Double(allGames) * 100)
    }
    
    var lostPercentage : Double {
        return (Double(lostGames) / Double(allGames)) * 100
    }
    
    var values :[Double] {
        return [wonPercentage , lostPercentage]
    }
    
    
   
    
}
