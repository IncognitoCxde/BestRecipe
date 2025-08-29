//
//  Recipe.swift
//  BestRecipe
//
//  Created by Administration  on 22/08/25.
//

import Foundation

struct Recipe {
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
