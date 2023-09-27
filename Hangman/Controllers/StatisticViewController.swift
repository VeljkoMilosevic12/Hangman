//
//  StatisticViewController.swift
//  Hangman
//
//  Created by Veljko Milosevic on 28/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//







import UIKit
import Charts

class StatisticViewController: UIViewController {
    
    @IBOutlet weak var stackViewTop: UIStackView!
    
    
    
    
    @IBOutlet weak var gamesPlayed: UILabel!
    @IBOutlet weak var gamesWon: UILabel!
    @IBOutlet weak var gamesLost: UILabel!
    @IBOutlet weak var pieView: PieChartView!
    
    @IBOutlet weak var controler: UILabel!
    
    @IBOutlet weak var gamesPlayedTitle: UILabel!
    
    @IBOutlet weak var gamesWonTitle: UILabel!
    
    
    @IBOutlet weak var gamesLostTitile: UILabel!
    
    
    @IBOutlet weak var greenBall: UILabel!
    
    @IBOutlet weak var redBall: UILabel!
    
    
    
   private var vm = StatisticVIewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let q:CGFloat = 29
        gamesPlayedTitle.font = UIFont(name: "Roboto-Medium", size: q.setSizeByWidth())
        gamesPlayed.font = UIFont(name: "Roboto-Regular", size: q.setSizeByWidth() - 1)
        let gW:CGFloat = 17
        print(gW.setSizeByWidth())
        gamesWon.font = UIFont(name: "Roboto-Regular", size: gW.setSizeByWidth())
         gamesLost.font = UIFont(name: "Roboto-Regular", size: gW.setSizeByWidth())
        gamesWonTitle.font = UIFont(name: "Roboto-Medium", size: gW.setSizeByWidth())
        gamesLostTitile.font = UIFont(name: "Roboto-Medium", size: gW.setSizeByWidth())
        controler.font = UIFont(name: "Roboto-Medium", size: q.setSizeByWidth())
        greenBall.font = UIFont(name: "Roboto-Medium", size: gW.setSizeByWidth())
        redBall.font = UIFont(name: "Roboto-Medium", size: gW.setSizeByWidth())
        
        
        let fg:CGFloat = 6
        
        
        stackViewTop.spacing = fg.setSizeByWidth()
        
        let spacing:CGFloat = 4
        
        stackWin.spacing = spacing.setSizeByWidth()
        stackLose.spacing = spacing.setSizeByWidth()
        
        
    }
    @IBOutlet weak var stackWin: UIStackView!
    @IBOutlet weak var stackLose: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDisplay()
        
        
    }
    
    func setupDisplay() {
        
        let numAll = vm.allGames
        let numWon = vm.wonGames
        let numLost = vm.lostGames
        let datapoints = ["Win", "Lose"]
        gamesPlayed.text = String(numAll)
        gamesWon.text = String(numWon)
        gamesLost.text = String(numLost)
        
        let wonPercentage = vm.wonPercentage
        let LostPercentage = vm.lostPercentage
            
        let values = [wonPercentage, LostPercentage]
        
        pieView.setChart(dataPoints: datapoints, values: values)
        
    }
    
    @IBAction func goTomenuButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    

 
}
