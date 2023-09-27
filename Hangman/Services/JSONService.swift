//
//  JSONService.swift
//  Hangman
//
//  Created by Veljko Milosevic on 27/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import Foundation

class JSONService {
    
   static func loadJson(completion: @escaping ([GuessingCategory]) -> Void) {
        if let path = Bundle.main.path(forResource: "Categories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let categories = try JSONDecoder().decode([GuessingCategory].self, from: data)
                completion(categories)
            } catch {
                
            }
        }
    }
}
