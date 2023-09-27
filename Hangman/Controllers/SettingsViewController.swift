//
//  SettingsViewController.swift
//  Hangman
//
//  Created by Veljko Milosevic on 22/04/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit
import StoreKit

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var removeAdsLabel: UILabel!
    var models = [SKProduct]()

    
    
    @IBOutlet weak var musicSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.rowHeight = 44
        SKPaymentQueue.default().add(self)
        fetchProducts()
        

    }
    
    
    @IBAction func music(_ sender: UISwitch) {
        let state = sender.isOn
        AppSettings.shared.soundOn = state
        tableView.reloadData()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView(frame: .zero)
        updateUI()
       
    }
    
    @IBAction func choseTheme(_ sender: Any) {
        
        if AppSettings.shared.adsPurchased == false {
            let payment = SKPayment(product: models.first!)
            SKPaymentQueue.default().add(payment)
        }
        else {return}
        
    }
    enum Product:String , CaseIterable {
        case removeAds = "com.myApp.removeAds"
        
    }
    
    
    
    func updateUI() {
        musicSwitch.isOn = AppSettings.shared.soundOn
        musicSwitch.onTintColor = AppSettings.shared.themeColor
    }
    
    @IBAction func clearStats(_ sender: UIButton) {
        let alert = UIAlertController(title: "Clear stats ?", message: "This operation cannot undo", preferredStyle: .alert)
        let clear = UIAlertAction(title: "Clear", style: .default) { (_) in
            StatsService.shared.clear()
        }
        let close = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        alert.addAction(clear)
        alert.addAction(close)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}


extension SettingsViewController: SKProductsRequestDelegate,SKPaymentTransactionObserver {
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({$0.rawValue})))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest,didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
        
            print(response.products)
            self.models = response.products
            let product = self.models[0]
            self.removeAdsLabel.text = "\(product.localizedTitle) - (\(product.priceLocale.currencySymbol ?? "$") \(product.price))"
            if AppSettings.shared.adsPurchased == true {
                self.removeAdsLabel.text = "Remove Ads - Purchased"
                self.tableView.reloadData()
            }
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //
        
        transactions.forEach {
            switch $0.transactionState {
            
            case .purchasing:
                print("purchasing")
            case .purchased:
                print("purchased")
                SKPaymentQueue.default().finishTransaction($0)
                AppSettings.shared.adsPurchased = true
            case .failed:
                print("failed")
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                print("restored")
                break
            case .deferred:
                print("deffered")
                break
            @unknown default:
                print("defail")
                break
            }
          
        }
    }
    
    
    
}
