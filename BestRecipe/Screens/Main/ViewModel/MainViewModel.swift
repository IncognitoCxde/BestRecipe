//
//  MainViewModel.swift
//  BestRecipe
//
//  Created by iMacbook on 8/19/25.
//

import UIKit

class MainViewModel {
    
    private(set) var trendingRecipes: [Recipe] = []
    private(set) var allPopularRecipes: [Recipe] = []
    private(set) var filteredPopularRecipes: [Recipe] = []
    private(set) var recentRecipes: [Recipe] = []
    private(set) var popularCategories = ["Salad", "Breakfast", "Appetiser", "Noodle", "Lunch", "Dessert"]
    
    func loadMockData() {
        trendingRecipes = [
            Recipe(id: 1, title: "Spicy Salmon with edamame", image: "salmon", timeTaken: 60, servings: 4, sourceName: "", sourceUrl: "", healthScore: 7.9, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: ""),
            Recipe(id: 2, title: "The Perfect Filet Mignon", image: "steak", timeTaken: 45, servings: 2, sourceName: "", sourceUrl: "", healthScore: 5.8, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: ""),
            Recipe(id: 3, title: "Authentic Fettuccine Alfredo", image: "spaghetti", timeTaken: 30, servings: 3, sourceName: "", sourceUrl: "", healthScore: 8.2, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "")
        ]
        
        allPopularRecipes = [
            Recipe(id: 1, title: "Chicken and \nVegetable Wrap", image: "wrap", timeTaken: 15, servings: 2, sourceName: "", sourceUrl: "", healthScore: 7, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "Breakfast"),
            Recipe(id: 2, title: "Blueberry and \nLemon Pancakes", image: "pancake", timeTaken: 35, servings: 4, sourceName: "", sourceUrl: "", healthScore: 6, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "Breakfast"),
            Recipe(id: 3, title: "NYC-style \nCaramelised Burger", image: "burger", timeTaken: 45, servings: 3, sourceName: "", sourceUrl: "", healthScore: 5.5, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "Lunch")
        ]
        
        recentRecipes = [
            Recipe(id: 1, title: "NYC Ribeye Steak", image: "meat", timeTaken: 45, servings: 2, sourceName: "", sourceUrl: "", healthScore: 6, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: ""),
            Recipe(id: 2, title: "Veggie Cutlets", image: "egg", timeTaken: 20, servings: 3, sourceName: "", sourceUrl: "", healthScore: 7.9, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: ""),
            Recipe(id: 3, title: "Belgian Vanilla Waffles", image: "waffle", timeTaken: 15, servings: 2, sourceName: "", sourceUrl: "", healthScore: 6, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "")
        ]
        
        onDataUpdated?()
    }
    
    var onDataUpdated: (() -> Void)?
    
    var selectedCategory: String? {
        didSet {
            filterPopularRecipes()
        }
    }
    
    var onPopularRecipesUpdated: (() -> Void)?

    
    private func filterPopularRecipes() {
        if let category = selectedCategory {
            filteredPopularRecipes = allPopularRecipes.filter { $0.category == category }
        } else {
            filteredPopularRecipes = allPopularRecipes
        }
        
        onPopularRecipesUpdated?()
    }
    
    func recipes(for section: RecipeSectionType) -> [Recipe] {
        switch section {
        case .trending: return trendingRecipes
        case .popularCategories: return []
        case .popular: return allPopularRecipes
        case .recent: return recentRecipes
        }
    }
    
    func categories(for section: RecipeSectionType) -> [String] {
        switch section {
        case .popularCategories:
            return popularCategories
        default:
            return []
        }
    }

    
}
