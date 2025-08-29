//
//  RecipeDetails.swift
//  BestRecipe
//
//  Created by iMacbook on 8/29/25.
//


import Foundation

struct RecipeDetails {
    let title: String
    let time: String
    let imageName: String
    let rating: Double
    let reviews: Int
    let instructions: [String]
    let ingredients: [Ingredient]
}

struct Ingredient {
    let name: String
    let quantity: String
    let imageName: String
}
