//
//  AudioService.swift
//  Hangman
//
//  Created by Veljko Milosevic on 22/04/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation
import AVFoundation

class AudioService {
    
    enum Sound: String {
        case win = "win"
        case lose = "lose"
        case passed = "passed"
        case hanged = "hanged"
    }
    
    private var soundOn = AppSettings.shared.soundOn
    private var player: AVAudioPlayer!
    
    func playSound(sound:Sound) {
        if soundOn == true {
            guard let path = Bundle.main.path(forResource: sound.rawValue, ofType : "wav") else {return}
            let url = URL(fileURLWithPath : path)
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.play()
                
            } catch {
                print ("There is an issue with this code!")
            }
        }
        return
        
    }
    
}
