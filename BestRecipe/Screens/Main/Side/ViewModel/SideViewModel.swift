//
//  SideViewModel.swift
//  BestRecipe
//
//  Created by iMacbook on 8/30/25.
//

import UIKit

class SideViewModel {
    
    private(set) var trendingRecipes: [SideRecipe] = []
    private(set) var recentRecipes: [SideRecipe] = []
    
    let networkingManager: HomeNetworkingProtocol = HomeNetworkingManager()
    
    
    func loadMockTrendingData() {
    }
    
    var onDataUpdated: (() -> Void)?
    
    func fetchData(completion: @escaping () -> Void) {
        let group = DispatchGroup()
        
        group.enter()
        networkingManager.fetchFullTrending { [weak self] result in
            defer { group.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.trendingRecipes = response.results ?? []
            case .failure(let error):
                print("Error fetching trending recipes: \(error)")
            }
        }
        group.notify(queue: .main) {
            completion()
            self.onDataUpdated?()
        }
    }
    
    func fetchRecipeDetail(for id: Int, completion: @escaping (RecipeDetail?) -> Void) {
        networkingManager.fetchRecipeDetail(id: id) { result in
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
