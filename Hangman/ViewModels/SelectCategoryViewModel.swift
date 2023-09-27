//
//  SelectCategoryViewModel.swift
//  Hangman
//
//  Created by Veljko Milosevic on 27/03/2021.
//  Copyright © 2021 Veljko Milosevic. All rights reserved.
//

import UIKit

class SelectCategoryListViewModel {
    
   private var categories = [GuessingCategory]()
    
    init(_ categoriesViewModels: [GuessingCategory]) {
        self.categories = categoriesViewModels
    }
    
    func getCategory(at index: Int) -> SelectCategoryViewModel {
        
        return SelectCategoryViewModel(guessingCategory: categories[index])
    }
    
    var count: Int {
        return categories.count
    }
    
}

class SelectCategoryViewModel {
    
    init(guessingCategory:GuessingCategory) {
        self.guessingCategory = guessingCategory
        self.guessingWords = guessingCategory.words
    }
    
    private var guessingCategory : GuessingCategory!
    
    var categoryName: String {
        return guessingCategory.name
    }
    
    var categoryImage : UIImage {
        return UIImage(named: guessingCategory.image)!
    }
    
    var guessingWords: [GuessingWord]!
    
    
    
}

