//
//  CGFloat+Extensions.swift
//  Hangman
//
//  Created by Veljko Milosevic on 11.5.21..
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit

extension CGFloat {
    
    func setSizeByWidth() -> CGFloat {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let ratio:CGFloat = self / 414
        
        return screenWidth * ratio
    }
    
    func setSizeByHeight() -> CGFloat {
        let screenRect = UIScreen.main.bounds
        let screenHeight = screenRect.size.height
        let ratio:CGFloat = self / 736
        
        return screenHeight * ratio
        
    }
    
    func setNavFontSize() -> CGFloat{
        if UIDevice.current.userInterfaceIdiom == .pad {
            return self * 1.13 + 2
        }
        else {
            return self
        }
    }
    
}
