//
//  Endpoints.swift
//  BestRecipe
//
//  Created by iMacbook on 9/1/25.
//

// search: https://api.spoonacular.com/recipes/complexSearch
// collections: 

import Foundation

enum Endpoint {
    static let baseURL = "https://spoonacular.com/food-api"

    case trending(number: Int)
    case popularCategories(type: String, number: Int)
    case popularRecipes(number: Int)
    case recent(number: Int)
    case search(query: String, number: Int)

    var path: String {
        switch self {
        case .trending:
            return "/recipes/random"
        case .popularCategories:
            return "/recipes/complexSearch"
        case .popularRecipes:
            return "/recipes/complexSearch"
        case .recent:
            return "/recipes/complexSearch"
        case .search(let query, let number):
            return "/recipes/search"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case .trending(let number):
            return [URLQueryItem(name: "number", value: "\(number)")]
        case .popularCategories(let type, let number):
            return [
                URLQueryItem(name: "type", value: type),
                URLQueryItem(name: "number", value: "\(number)")
            ]
        case .popularRecipes(let number):
            return [
                URLQueryItem(name: "sort", value: "popularity"),
                URLQueryItem(name: "number", value: "\(number)")
            ]
        case .recent(let number):
            return [
                URLQueryItem(name: "sort", value: "date"),
                URLQueryItem(name: "number", value: "\(number)")
            ]
        case .search(let query, let number):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "number", value: "\(number)")
            ]
        }
    }
}
