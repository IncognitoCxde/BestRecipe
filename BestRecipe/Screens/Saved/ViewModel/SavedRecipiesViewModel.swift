//
//  SavedRecipiesViewModel.swift
//  BestRecipe
//
//  Created by Administration  on 22/08/25.
//

import Foundation

class SavedRecipesViewModel {
    var recipes: [Recipe] = [] {
        didSet {
            onRecipesUpdated?()
        }
    }

    var onRecipesUpdated: (() -> Void)?

    func loadSavedRecipes() {
        self.recipes = [
            Recipe(
                title: "How to make shawarma at home",
                time: "15:10",
                imageName: "recipe1",
                rating: 5.0,
                reviews: 300,
                instructions: ["Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop.", "Place chopped eggs in a bowl.", "Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice.", "Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper."],
                ingredients: [
                    Ingredient(name: "Fish", quantity: "200g", imageName: "fish"),
                    Ingredient(name: "Ginger", quantity: "100g", imageName: "ginger"),
                    Ingredient(name: "Vegetable Oil", quantity: "80g", imageName: "oil"),
                    Ingredient(name: "Salt", quantity: "50g", imageName: "salt"),
                    Ingredient(name: "Cucumber", quantity: "200g", imageName: "cucumber")
                ]
            ),
            Recipe(
                title: "How to make shawarma at home",
                time: "15:10",
                imageName: "recipe2",
                rating: 5.0,
                reviews: 300,
                instructions: ["Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop.", "Place chopped eggs in a bowl.", "Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice.", "Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper."],
                ingredients: [
                    Ingredient(name: "Eggs", quantity: "2", imageName: "fish"),
                    Ingredient(name: "Ginger", quantity: "100g", imageName: "ginger"),
                    Ingredient(name: "Vegetable Oil", quantity: "80g", imageName: "oil"),
                    Ingredient(name: "Salt", quantity: "50g", imageName: "salt"),
                    Ingredient(name: "Chicken", quantity: "400g", imageName: "cucumber")
                ]
            )
        ]
    }
}
