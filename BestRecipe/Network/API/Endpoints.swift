//
//  Endpoints.swift
//  BestRecipe
//
//  Created by iMacbook on 9/1/25.
//

// Link: https://api.spoonacular.com/recipes/complexSearch

import Foundation

enum Endpoint {
    static let baseURL = "https://spoonacular.com/food-api"

    case trending
    case fullTrending
    case popularCategories(category: String)
    case popularRecipes
    case search(query: String)
    case details(id: Int)
    

    var path: String {
        switch self {
        case .trending, .fullTrending, .popularRecipes, .popularCategories, .search:
            return "/recipes/complexSearch"
        case .details(let id):
            return "/recipes/\(id)/information"
        }
    }
    
}
