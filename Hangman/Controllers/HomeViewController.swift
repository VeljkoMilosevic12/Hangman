//
//  ViewController.swift
//  Hangman
//
//  Created by Veljko Milosevic on 27/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var onePlayerButton: CustomButton!
    @IBOutlet weak var twoPlayers: CustomButton!
    @IBOutlet weak var statisticButton: CustomButton!
    @IBOutlet weak var settingsButton: CustomButton!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: Cons outlets
    
    @IBOutlet weak var consStackToBottom: NSLayoutConstraint!
    @IBOutlet weak var consImageTOTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitiaDisplayValues()
    }
    
    
    private func setupInitiaDisplayValues() {
        
        
        let spacingStackViewToBotton:CGFloat = 60
        let spacingImageToTop:CGFloat = 60
        let stackViewSpacing:CGFloat = 40
        let fontSize:CGFloat = 24
        let borderWidth:CGFloat = 2
        
        consImageTOTop.constant = spacingImageToTop.setSizeByHeight()
        consStackToBottom.constant = spacingStackViewToBotton.setSizeByHeight()
        stackView.spacing = stackViewSpacing.setSizeByHeight()
        
        [onePlayerButton,twoPlayers,statisticButton,settingsButton].forEach({$0?.titleLabel?.font = UIFont(name: "Roboto-BoldItalic", size: fontSize.setSizeByWidth()); $0?.borderWidth = borderWidth.setSizeByWidth()})
        
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toMGame" else { return }
        guard let gameVC = segue.destination as? MultiplayerViewController else { return }
        let multiplayerMode = MultiplayerViewModel()
        gameVC.vm = multiplayerMode
        multiplayerMode.delegate = gameVC
        
        
    }
}


