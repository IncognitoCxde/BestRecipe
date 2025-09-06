//
//  MainViewModel.swift
//  BestRecipe
//
//  Created by iMacbook on 8/19/25.
//

import UIKit

class MainViewModel {
    
    
    let networkingManager: HomeNetworkingProtocol = HomeNetworkingManager()
    let response = RecipesResponse()
    
    var trendingRecipes: [Recipe] = []
    var allPopularRecipes: [Recipe] = []
    var filteredPopularRecipes: [Recipe] = []
    var recentRecipes: [Recipe] = []
    var categories: [Category] = [
        Category(name: "Salad"),
        Category(name: "Appetizer"),
        Category(name: "Main Dish"),
        Category(name: "Side Dish"),
        Category(name: "Dessert"),
        Category(name: "Beverage")
    ]
    
    var onDataUpdated: (() -> Void)?
    
    func loadMockData() {
        //        trendingRecipes = [
        //            Recipe(id: 1, title: "Spicy Salmon with edamame", image: "salmon", timeTaken: 60, servings: 4, sourceName: "", sourceUrl: "", healthScore: 7.9, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: ""),
        //            Recipe(id: 2, title: "The Perfect Filet Mignon", image: "steak", timeTaken: 45, servings: 2, sourceName: "", sourceUrl: "", healthScore: 5.8, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: ""),
        //            Recipe(id: 3, title: "Authentic Fettuccine Alfredo", image: "spaghetti", timeTaken: 30, servings: 3, sourceName: "", sourceUrl: "", healthScore: 8.2, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "")
        //        ]
        
        //        allPopularRecipes = [
        //            Recipe(id: 1, title: "NYC-style \nCaramelised Burger", image: "burger", timeTaken: 45, servings: 3, sourceName: "", sourceUrl: "", healthScore: 5.5, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "Lunch"),
        //            Recipe(id: 2, title: "Chicken and \nVegetable Wrap", image: "wrap", timeTaken: 15, servings: 2, sourceName: "", sourceUrl: "", healthScore: 7, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "Breakfast"),
        //            Recipe(id: 3, title: "Blueberry and \nLemon Pancakes", image: "pancake", timeTaken: 35, servings: 4, sourceName: "", sourceUrl: "", healthScore: 6, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "Breakfast")
        //            ]
        
        //        recentRecipes = [
        //            Recipe(id: 1, title: "NYC Ribeye Steak", image: "meat", timeTaken: 45, servings: 2, sourceName: "", sourceUrl: "", healthScore: 6, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: ""),
        //            Recipe(id: 2, title: "Veggie Cutlets", image: "egg", timeTaken: 20, servings: 3, sourceName: "", sourceUrl: "", healthScore: 7.9, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: ""),
        //            Recipe(id: 3, title: "Belgian Vanilla Waffles", image: "waffle", timeTaken: 15, servings: 2, sourceName: "", sourceUrl: "", healthScore: 6, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"), category: "")
        //        ]
        //
        //        onDataUpdated?()
    }
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        group.enter()
        networkingManager.fetchTrending { [weak self] result in
            defer { group.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.trendingRecipes = response.results ?? []
            case .failure(let error):
                print("Error fetching trending recipes: \(error)")
            }
        }
        
        group.enter()
        networkingManager.fetchPopular { [weak self] result in
            defer { group.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.allPopularRecipes = response.results ?? []
            case .failure(let error):
                print("Error fetching popular recipes: \(error)")
            }
        }
        
        group.notify(queue: .main) {
            completion()
            self.onDataUpdated?()
        }
    }
    
    func fetchRecipes(for category: Category, completion: @escaping () -> Void) {
        let normalized = normalizeCategoryName(category.name)
        guard let apiCategory = Categories(rawValue: normalized) else {
            print("Unknown category: \(category.name)")
            completion()
            return
        }
        
        networkingManager.fetchRecipesByPopularCategory(for: apiCategory) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.allPopularRecipes = response.results ?? []
                case .failure(let error):
                    print("Error fetching \(apiCategory.rawValue) recipes: \(error)")
                }
                completion()
                self.onDataUpdated?()
            }
        }
    }
    
    func recipes(for section: RecipeSectionType) -> [Recipe] {
        switch section {
        case .trending: return trendingRecipes
        case .popularCategories: return []
        case .popular: return allPopularRecipes
        case .recent: return recentRecipes
        }
    }
    
    func categories(for section: RecipeSectionType) -> [Category] {
        switch section {
        case .popularCategories:
            return categories
        default:
            return []
        }
    }
    
    private func normalizeCategoryName(_ name: String) -> String {
        switch name.lowercased() {
        case "main dish", "main course":
            return "main course"
        case "side", "side dish":
            return "side dish"
        default:
            return name.lowercased()
        }
    }
    
}
