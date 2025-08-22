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
    let timeTaken: Int?
    let servings: Int?
    let sourceName: String?
    let sourceUrl: String?
    let healthScore: Double?
    let creator: Creator
    let category: String?
}

// MARK: - Creator Model

struct Creator: Codable {
    let name: String
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


// MARK: - API response manager

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}
