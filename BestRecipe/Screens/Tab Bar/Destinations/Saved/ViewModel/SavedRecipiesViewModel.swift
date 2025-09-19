//
//  SavedRecipiesViewModel.swift
//  BestRecipe
//
//  Created by Irina  on 22/08/25.
//

import Foundation

class SavedRecipesViewModel {
    private let network = HomeNetworkingManager()

    var recipes: [Recipe] = [] {
        didSet {
            onRecipesUpdated?()
        }
    }

    var onRecipesUpdated: (() -> Void)?

    func loadSavedRecipes() {
        let ids = SaveManager.shared.getFavorites()
        recipes = []
        
        let group = DispatchGroup()
        var fetched: [Recipe] = []
        
        for id in ids {
            group.enter()
            network.fetchRecipeDetail(id: id) { result in
                defer { group.leave() }
                switch result {
                case .success(let detail):
                    let recipe = Recipe(
                        id: detail.id ?? id,
                        title: detail.title ?? "Unknown",
                        image: detail.image ?? "",
                        readyInMinutes: detail.readyInMinutes,
                        servings: detail.servings,
                        sourceName: nil,
                        sourceUrl: nil,
                        healthScore: nil,
                        author: nil,
                        category: nil
                    )
                    fetched.append(recipe)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            print("Current favorites: \(SaveManager.shared.getFavorites())")
            self.recipes = fetched
        }
    }
    
    func removeRecipe(withID id: Int, completion: @escaping (Int?) -> Void) {
        SaveManager.shared.remove(id: id)
        recipes.removeAll(where: { $0.id == id })
        onRecipesUpdated?()
        completion(nil)
    }

    func fetchRecipeDetail(for id: Int, completion: @escaping (RecipeDetail?) -> Void) {
            network.fetchRecipeDetail(id: id) { result in
                switch result {
                case .success(let detail):
                    completion(detail)
                case .failure(let error):
                    print("Failed to fetch detail: \(error)")
                    completion(nil)
                }
            }
        }
    
}
