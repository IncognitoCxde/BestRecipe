//
//  RecipeDetailViewModel.swift
//  BestRecipe
//
//  Created by Administration  on 26/08/25.
//

import Foundation

class RecipeDetailViewModel {
    private(set) var recipe: RecipeDetail

    init(recipe: RecipeDetail) {
        self.recipe = recipe
    }

    var recipeTitle: String {
        recipe.title ?? "No Title"
    }

    var recipeInstructions: [String] {
        if let instructions = recipe.instructions {
            return instructions.components(separatedBy: ". ").filter { !$0.isEmpty }
        }
        return []
    }

    var recipeIngredients: [ingredient] {
        recipe.extendedIngredients
    }

    var recipeRatingText: String {
        return String(format: "%.1f", 4.5)
    }

    var recipeReviewsText: String {
        return "(125 Reviews)"
    }
}
