//
//  MultiplayerViewController.swift
//  Hangman
//
//  Created by Veljko Milosevic on 30/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit

class MultiplayerViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var images: [UIImageView]!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var kons: UIImageView!
    @IBOutlet weak var alertView: CustomView!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var stackViewTopButtons: UIStackView!
    @IBOutlet weak var stackViewMidButtons: UIStackView!
    @IBOutlet weak var stackViewBottonButtons: UIStackView!
    
    @IBOutlet weak var vju: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var playButton: CustomButton!
    @IBOutlet weak var alertViewTwo: CustomButton!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var imageAlert: UIImageView!
    @IBOutlet weak var stackViewButtons: UIStackView!
    @IBOutlet weak var konsImage: UIImageView!
    @IBOutlet weak var insertWordLabel: UILabel!
    
    @IBOutlet weak var consNextButtonToBottom: NSLayoutConstraint!
    @IBOutlet weak var constDisplayTopView: NSLayoutConstraint!
    @IBOutlet weak var consViewToTop: NSLayoutConstraint!
    @IBOutlet weak var constDisplayTOButtons: NSLayoutConstraint!
    @IBOutlet weak var constButtonsToBottom: NSLayoutConstraint!
    @IBOutlet weak var imageToTop: NSLayoutConstraint!
    
    @IBOutlet weak var consPlayToBottom: NSLayoutConstraint!
    
    @IBOutlet weak var consAlertViewMiddle: NSLayoutConstraint!
    
   
 
    var audioService = AudioService()
    var vm: MultiplayerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Multiplayer"
        wordTextField.delegate = self
        alertViewTwo.isHidden = true
        alertView.isHidden = true
        alertView.alpha = 0
        alertViewTwo.alpha = 0
        
        alertView.isUserInteractionEnabled = true
        blurUI(blur: .yes)
        wordTextField.becomeFirstResponder()
        
        let buttomsFontSize:CGFloat = 22.5
        buttons.forEach { (button) in
            button.titleLabel?.font = UIFont.systemFont(ofSize: buttomsFontSize.setSizeByWidth(), weight: .semibold)
        }
        display.font = UIFont(name: "Courier", size: buttomsFontSize.setSizeByWidth())
        let ratio:CGFloat = 0.040
        consViewToTop.constant = view.frame.height * ratio
        
        let textRatio:CGFloat = 21
        let textRatio2:CGFloat = 15
        
        titleLabel.font = UIFont(name: "Roboto-Medium", size: textRatio.setSizeByWidth())
        wordLabel.font = UIFont(name: "Roboto-Medium", size: textRatio2.setSizeByWidth())
        
        buttonNext.titleLabel?.font = UIFont(name: "Roboto-Medium", size: textRatio)
        
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
        
        
        imageToTop.constant = view.frame.height * 0.000135
        
        let textConstatn:CGFloat = 19
        
        insertWordLabel.font = UIFont(name: "Roboto-Regular", size: textConstatn.setSizeByWidth())
        playButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: textConstatn.setSizeByWidth() - 2)
        
        
        let a:CGFloat = 16

        consPlayToBottom.constant = a.setSizeByWidth()
        
        wordTextField.font = UIFont(name: "Roboto-Regular", size: textConstatn.setSizeByWidth())
        let spacing:CGFloat = 15
        consNextButtonToBottom.constant = spacing

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            print("height jee \(keyboardHeight)")
            consAlertViewMiddle.constant  =  -keyboardHeight / 2 + alertView.frame.height / 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private var result:String {
        get {
            return vm.result
        }
        set {
            display.text = newValue
            let cus = Double(view.frame.width * 0.008)
            display.addCharacterSpacing(custom: cus)
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        setupButtonOnClick(button: sender)
        
        let letter = Character(sender.currentTitle!)
        checkClickedLetter(letter: letter)
        
    }
    
    private func checkClickedLetter(letter:Character) {
        vm.checkPressedLetter(letter) { bad in
            self.setupImagesByErrors(errorCount: bad)
        }
        result = vm.result
    }
    
    private func setupDisplay() {
        clearUI()
    }
    
    private func clearUI() {
        
        buttons.forEach({
            $0.isEnabled = true
            $0.setTitleColor(.white, for: .normal)
        })
        images.forEach({$0.isHidden = true})
        
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
    
    
    @IBAction func playButtonClicked(_ sender: Any) {
        
        setupDisplay()
        guard let word = wordTextField.text , word != "" , word != " " else {
            
            self.navigationController?.popViewController(animated: true)
            return}
        
        self.vm.setupWord(word: word.uppercased())
        self.result = self.vm.result
        blurUI(blur: .no)
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        alertViewTwo.isHidden = true
        self.blurUI(blur: .yes)
    }
    
    
}


extension MultiplayerViewController : ModeDelegate {
    func passedAll() {
        return
    }
    
    
    func gameWon(_ currentWord: String) {
        self.setupDisplay()
        self.blurUI(blur: .neutral)
        alertView.isHidden = true
        self.audioService.playSound(sound: .passed)
        self.alertViewTwo.isHidden = false
        UIView.animate(withDuration: 0.8) {
            self.alertViewTwo.alpha = 1
        }
        self.wordLabel.text = "The guessing word : \(vm.guessingWord.lowercased().capitalized)"
        self.titleLabel.text = "That's correct"
        imageAlert.image = #imageLiteral(resourceName: "w")
        
        
    }
    
    func gameLost(_ currentWord: String) {
        
        self.setupDisplay()
        self.blurUI(blur: .neutral)
        alertView.isHidden = true
        self.audioService.playSound(sound: .hanged)
        
        self.alertViewTwo.isHidden = false
        UIView.animate(withDuration: 0.8) {
            self.alertViewTwo.alpha = 1
        }
        self.wordLabel.text = "The guessing word : \(vm.guessingWord.lowercased().capitalized)"
        self.titleLabel.text = "That's not correct !!"
        imageAlert.image = #imageLiteral(resourceName: "X")
        
    }
    
    
    private enum Blur {
        case yes
        case no
        case neutral
    }
    
    private func blurUI(blur:Blur) {
        switch blur {
        case .yes:
            
            blurView.isHidden = false
            alertViewTwo.alpha = 0
            alertViewTwo.isHidden = true
            UIView.animate(withDuration: 0.8) {
                self.alertView.isHidden = false
                self.alertView.alpha = 1
                self.alertView.isUserInteractionEnabled = true
            }
            self.wordTextField.text = ""
            self.alertViewTwo.isHidden = true
        case .no:
            
            blurView.isHidden = true
            alertView.isHidden = true
            alertView.alpha = 1
            alertView.isUserInteractionEnabled = false
            self.alertViewTwo.isHidden = true
            
        case .neutral:
            
            blurView.isHidden = false
            alertViewTwo.alpha = 1
            alertViewTwo.isHidden = false
            self.wordTextField.text = ""
            
            
        }
        
    }
    
}


extension MultiplayerViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        let alphabet = allowedCharacterSet.isSuperset(of: typedCharacterSet)
        let maxLength = 12
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        return alphabet && newString.length <= maxLength
        
    }
}
