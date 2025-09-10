//
//  RecipeSectionType.swift
//  BestRecipe
//
//  Created by iMacbook on 9/10/25.
//


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
