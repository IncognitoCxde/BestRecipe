//
//  SearchRecipe.swift
//  BestRecipe
//
//  Created by iMacbook on 9/19/25.
//

struct SearchRecipe: Codable {
    let id: Int?
    let title: String?
    let image: String?
}

struct SearchRecipesResponse: Codable {
    var results: [SearchRecipe]?
}

