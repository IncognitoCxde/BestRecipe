//
//  TrendingRecipe.swift
//  BestRecipe
//
//  Created by iMacbook on 8/30/25.
//

struct SideRecipe: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let timeTaken: Int?
    let rating: Double?
    let numberOfIngredients: Int?
}

struct FullRecipeResponse: Codable {
    var results: [SideRecipe]?
}
