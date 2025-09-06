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
//        trendingRecipes = [
//            SideRecipe(id: 1, title: "Spicy Salmon with edamame", image: "salmon", timeTaken: 60, rating: 5.0, numberOfIngredients: 9),
//            SideRecipe(id: 2, title: "The Perfect Filet Mignon", image: "steak", timeTaken: 45, rating: 5.0, numberOfIngredients: 4),
//            SideRecipe(id: 3, title: "Authentic Fettuccine Alfredo", image: "spaghetti", timeTaken: 30, rating: 5.0, numberOfIngredients: 6)
//        ]
        recentRecipes = [
            SideRecipe(id: 1, title: "NYC Ribeye Steak", image: "meat", timeTaken: 45, rating: 5.0, numberOfIngredients: 4),
            SideRecipe(id: 2, title: "Veggie Cutlets", image: "egg", timeTaken: 20, rating: 5.0, numberOfIngredients: 5),
            SideRecipe(id: 3, title: "Belgian Vanilla Waffles", image: "waffle", timeTaken: 15, rating: 5.0, numberOfIngredients: 6)
        ]
        onDataUpdated?()
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
}
