//
//  ViewController + Alert Extensions.swift
//  Hangman
//
//  Created by Veljko Milosevic on 28/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit

extension UIViewController {

enum AlertType {
    case win
    case lose
    case passed
}

func setupAlert(type:AlertType, word:String, handler: @escaping() -> Void) {
    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    
    switch type {
    case .win:
        alert.title = "Congratulations"
        alert.message = "Word is : \(word.lowercased().capitalized)"
    case .lose:
        alert.title = "Thats wrong"
        alert.message = "Word is : \(word.lowercased().capitalized)"
    case .passed:
        alert.title = "U have completed all words"
        alert.message = "Go to the categories"
        
    }
    let nextButton = UIAlertAction(title: "Next", style: .default) { (_) in
        handler()
    }
    alert.addAction(nextButton)
    self.present(alert, animated: true, completion: nil)
    
}

}
