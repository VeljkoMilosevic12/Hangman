//
//  PieChart+Extensions.swift
//  Hangman
//
//  Created by Veljko Milosevic on 29/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Charts

extension PieChartView {
    
    func setChart(dataPoints:[String],values:[Double]) {
        var dataEntries = [PieChartDataEntry]()
        for i in 0..<dataPoints.count {
            let dataEntry =  PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "")
        pieChartDataSet.sliceSpace = 5
        pieChartDataSet.selectionShift = 2

        
        let colors = [([#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.8460897843, green: 0.02618473401, blue: 0.3785707442, alpha: 1)] , #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),([#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)] , #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)),([#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.3333333333, green: 0.937254902, blue: 0.768627451, alpha: 1)] , UIColor.black),([#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)] , #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),([#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)] , #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]
        
        let selectedColor = colors.randomElement()!
        pieChartDataSet.colors = selectedColor.0
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        let fontData:CGFloat = 14
        pieChartData.setValueFont(UIFont(name: "HelveticaNeue-Light", size: fontData.setSizeByWidth())!)
        pieChartData.setValueTextColor(selectedColor.1)
        self.legend.form = .circle
        self.legend.textColor = UIColor.black
        let font:CGFloat = 15
        self.legend.font = UIFont(name: "HelveticaNeue-Light", size: font.setSizeByWidth())!
        self.legend.formSize = 20
        
        self.data = pieChartData
        self.setNeedsDisplay()
        self.animate(xAxisDuration: 2.0,easingOption: .easeOutElastic)
        
        
    }
}

