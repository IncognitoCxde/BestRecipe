//
//  Recipe.swift
//  BestRecipe
//
//  Created by iMacbook on 9/10/25.
//


struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int?
    let servings: Int?
    let sourceName: String?
    let sourceUrl: String?
    let healthScore: Double?
    let author: Author?
    let category: String?
}
