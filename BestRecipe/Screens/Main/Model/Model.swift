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
    let author: author?
    let category: String?
}

// MARK: - Recipe Details

struct RecipeDetail: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let readyInMinutes: Int?
    let servings: Int?
    let instructions: String?
    let extendedIngredients: [ingredient]
}

struct ingredient: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let amount: Double?
    let unit: String?
}

// MARK: - Creator Model

struct author: Codable {
    let name: String?
    let profileImageUrl: String?
}

// MARK: - Sections enum

enum RecipeSectionType: Int, CaseIterable {
    case trending
    case popularCategories
    case popular
    case recent
    
    var title: String {
        switch self {
        case .trending: return "Trending Now 🔥"
        case .popular: return "Popular category"
        case .recent: return "Recent recipes"
        case .popularCategories:
            return ""
        }
    }
}

// MARK: - Category

struct Category {
    let name: String
}

// MARK: - Categories enum

enum Categories: String, Equatable {
    case salad = "salad"
    case appetizer = "appetizer"
    case mainCourse = "main course"
    case sideDish = "side dish"
    case dessert = "dessert"
    case breakfast = "breakfast"
    case beverage = "beverage"
    
    var stringValue: String {
        rawValue
    }
}


// MARK: - API response manager

struct RecipesResponse: Codable {
    var results: [Recipe]?
}
