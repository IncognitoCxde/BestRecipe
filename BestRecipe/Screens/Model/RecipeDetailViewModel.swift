//
//  RecipeDetailViewModel.swift
//  BestRecipe
//
//  Created by Administration  on 26/08/25.
//

import Foundation

class RecipeDetailViewModel {
    private(set) var recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    var recipeTitle: String {
        recipe.title
    }

    var recipeRatingText: String {
        String(format: "%.1f", recipe.rating)
    }

    var recipeReviewsText: String {
        "(\(recipe.reviews) Reviews)"         
    }

    var recipeInstructions: [String] {
        recipe.instructions
    }

    var recipeIngredients: [Ingredient] {
        recipe.ingredients
    }
}
