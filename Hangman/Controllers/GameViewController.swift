//
//  GameViewController.swift
//  Hangman
//
//  Created by Veljko Milosevic on 27/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit
import GoogleMobileAds
import StoreKit


class GameViewController: UIViewController {
    
    @IBOutlet weak var imageAlert: UIImageView!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var alertView: CustomButton!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var images: [UIImageView]!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var konsImage: UIImageView!
    @IBOutlet weak var stackViewTopButtons: UIStackView!
    @IBOutlet weak var stackViewMidButtons: UIStackView!
    @IBOutlet weak var stackViewBottonButtons: UIStackView!
    @IBOutlet weak var stackViewButtons: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var vju: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var imageToTop: NSLayoutConstraint!
    @IBOutlet weak var consNextButtonToBottom: NSLayoutConstraint!
    @IBOutlet weak var constDisplayTopView: NSLayoutConstraint!
    @IBOutlet weak var consViewToTop: NSLayoutConstraint!
    @IBOutlet weak var constDisplayTOButtons: NSLayoutConstraint!
    @IBOutlet weak var constButtonsToBottom: NSLayoutConstraint!
    
    
    private var completed = false
    private var audioService = AudioService()
    var interstitial: GADInterstitialAd?
    var realId = "ca-app-pub-2305667353248953/5490897922"
    var vm:Strategy!
    var counter = 1
    var models = [SKProduct]()
    
    private var result:String {
        get {
            return vm.result
        }
        set {
            display.text = newValue
            let spacing = Double(view.frame.width * 0.011439)
            display.addCharacterSpacing(custom: spacing)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupAd()
        
        setupDisplay()
        self.title = vm.title
        let buttomsFontSize:CGFloat = 22
        let fontSize = buttomsFontSize.setSizeByWidth()
        buttons.forEach { (button) in
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        }
        display.font = UIFont(name: "Courier", size: fontSize)
        let ratio:CGFloat = 0.040
        consViewToTop.constant = view.frame.height * ratio
        
        let textRatio:CGFloat = 21
        let textRatio2:CGFloat = 15
        
        titleLabel.font = UIFont(name: "Roboto-Medium", size: textRatio.setSizeByWidth())
        wordLabel.font = UIFont(name: "Roboto-Medium", size: textRatio2.setSizeByWidth())
       
        buttonNext.titleLabel?.font = UIFont(name: "Roboto-Medium", size: textRatio.setSizeByWidth())
        
        let buttonsToBototmRatio:CGFloat = 0.04076
        constButtonsToBottom.constant = view.frame.height * buttonsToBototmRatio
        
        let displayToButtonsRatio:CGFloat = 0.0271
        let stackSpacingRatio:CGFloat = 0.0203
        
        stackViewButtons.spacing = view.frame.height * stackSpacingRatio
        
        constDisplayTOButtons.constant = view.frame.height * displayToButtonsRatio
        
        let stackSpacingWidthRatio:CGFloat = 0.0053
        
        stackViewTopButtons.spacing = view.frame.width * stackSpacingWidthRatio
        stackViewMidButtons.spacing = view.frame.width * stackSpacingWidthRatio
        stackViewBottonButtons.spacing = view.frame.width * stackSpacingWidthRatio
        
        buttons.forEach({$0.layer.cornerRadius = 5})
        
        let consDisplayToVIewRatio:CGFloat = 0.07608
        constDisplayTopView.constant = view.frame.height * consDisplayToVIewRatio
        
        display.layer.cornerRadius = 10
        display.clipsToBounds = true
        
        vju.layer.cornerRadius = view.frame.height * 0.01358
        display.clipsToBounds = true
        
        buttonNext.layer.cornerRadius = 10
        buttonNext.clipsToBounds = true
        consNextButtonToBottom.constant = view.frame.height * 0.033
        
        imageToTop.constant = view.frame.height * 0.000135
        
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blurView.isHidden = true
        alertView.isUserInteractionEnabled = false
        alertView.isHidden = true
        alertView.alpha = 0
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        setupButtonOnClick(button: sender)
        
        let letter = Character(sender.currentTitle!)
        checkClickedLetter(letter: letter)
        result = vm.result
        
    }
    
    @IBAction func quitAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func checkClickedLetter(letter:Character) {
        vm.checkPressedLetter(letter) {[weak self] bad in
            self?.setupImagesByErrors(errorCount: bad)
        }
        
       
    }
    
    private func setupDisplay() {
        vm.setupQuestion {
            self.clearUI()
        }
    }
    
    private func clearUI() {
        
        let easyButton = String(result.first(where: {$0 != " " && $0 != "-"}) ?? "0")
        
        buttons.forEach({
            if $0.currentTitle == easyButton {
                $0.isEnabled = false
                $0.setTitleColor(.red, for: .disabled)
            }
            else {
                $0.isEnabled = true
                $0.setTitleColor(.white, for: .normal)
            }
        })
        images.forEach({$0.isHidden = true})
        self.result = self.vm.result
    }
    
    private func setupImagesByErrors(errorCount:Int) {
        images[errorCount].isHidden = false
    }
    
    private func setupButtonOnClick(button:UIButton) {
        button.setTitleColor(.red, for: .normal)
        button.isEnabled = false
    }
    
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        
        if completed == true {
            self.navigationController?.popViewController(animated: true)
        }
        else {
            
            blurUI(blur: .no)
            setupDisplay()
        }
        setupAd()
        counter += 1
        if AppSettings.shared.adsPurchased == false {
            if counter % 3 == 0 {
                if interstitial != nil {
                    interstitial!.present(fromRootViewController: self)
                } else {
                    print("Ad wasn't ready")
                }
            }
        }
        
    }
    
    private enum Blur {
        case yes
        case no
    }
    
    private func blurUI(blur:Blur) {
        switch blur {
        case .yes:

            blurView.isHidden = false
            self.alertView.isHidden = false
            self.alertView.alpha = 1
            self.alertView.isUserInteractionEnabled = true
        case .no:

            blurView.isHidden = true
            alertView.isHidden = true
            alertView.alpha = 0
            alertView.isUserInteractionEnabled = false
            
        }
        
    }
    
}


extension GameViewController : ModeDelegate {
    
    func gameWon(_ currentWord: String) {
        buttons.forEach({$0.isEnabled = false})
        UIView.animate(withDuration: 1) {
            self.blurUI(blur: .yes)
            
        }
        
        titleLabel.text = "That's correct"
        wordLabel.text = "The guessing word :  \(currentWord.lowercased().capitalized)"
        
        self.audioService.playSound(sound: .passed)
        StatsService.shared.wonGamesIncrement()
        imageAlert.image = UIImage(named: "w")
        
    }
    
    func gameLost(_ currentWord: String) {
        buttons.forEach({$0.isEnabled = false})
        UIView.animate(withDuration: 0.5) {
            self.blurUI(blur: .yes)
        }
        imageAlert.image = UIImage(named: "X")
        titleLabel.text = "That's not correct !!"
        wordLabel.text = "The guessing word : \(currentWord.lowercased().capitalized)"
        
        self.audioService.playSound(sound: .hanged)
        StatsService.shared.lostGamesIncrement()
    }
    
    
    
    func passedAll() {
        buttons.forEach({$0.isEnabled = false})
        UIView.animate(withDuration: 1) {
            self.blurUI(blur: .yes)
        }
        completed = true
        titleLabel.text = "U have completed all words"
        wordLabel.text = "Go to main menu"
        
        imageAlert.image = UIImage(named: "p")
        blurUI(blur: .yes)
    }
    
}

//
extension GameViewController:GADFullScreenContentDelegate {
    
    func setupAd () {
//        self.interstitial = nil
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:realId,request: request,completionHandler: { [weak self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            self?.interstitial = ad
            self?.interstitial?.fullScreenContentDelegate = self
        })
        

    }
    
    
    
    /// Tells the delegate that the ad failed to present full screen content.
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad presented full screen content.
      func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
      }
}



    
  
    
   
