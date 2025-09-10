//
//  RecipeDetail.swift
//  BestRecipe
//
//  Created by iMacbook on 9/10/25.
//


struct RecipeDetail: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let instructions: String?
    let extendedIngredients: [IngredientInfo]
}

