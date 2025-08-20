//
//  Model.swift
//  BestRecipe
//
//  Created by iMacbook on 8/19/25.
//

import UIKit

// MARK: - Recipe Model

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int?
    let servings: Int?
    let sourceName: String?
    let sourceUrl: String?
    let healthScore: Double?
    let creator: Creator
}

// MARK: - Creator Model

struct Creator: Codable {
    let name: String
    let profileImageUrl: String?
}

// MARK: - API response manager

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}
