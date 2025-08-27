//
//  SavedRecipiesViewModel.swift
//  BestRecipe
//
//  Created by Administration  on 22/08/25.
//

import Foundation

class SavedRecipiesViewModel {
    var recipes: [Recipe] = [] {
        didSet {
            onRecipesUpdated?()
        }
    }
 
    var onRecipesUpdated: (() -> Void)?
    
    
    func loadSavedRecipes() {
        self.recipes = [
            Recipe(title: "How to sharwama at home", time: "15:10", imageName: "recipe1", raiting: 5.0),
            Recipe(title: "How to sharwama at home", time: "15:10", imageName: "recipe2", raiting: 5.0)
        ]
    }
    
}
