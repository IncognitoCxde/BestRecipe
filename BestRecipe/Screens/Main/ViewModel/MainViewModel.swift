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
