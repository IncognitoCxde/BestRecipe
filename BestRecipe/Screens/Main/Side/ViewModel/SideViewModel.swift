//
//  SideViewModel.swift
//  BestRecipe
//
//  Created by iMacbook on 8/30/25.
//

class SideViewModel {
    private(set) var trendingRecipes: [TrendingRecipe] = []
    
    func loadMockTrendingData() {
        trendingRecipes = [
            TrendingRecipe(id: 1, title: "Spicy Salmon with edamame", image: "salmon", timeTaken: 60, rating: 5.0, numberOfIngerdients: 9),
            TrendingRecipe(id: 2, title: "The Perfect Filet Mignon", image: "steak", timeTaken: 45, rating: 5.0, numberOfIngerdients: 4),
            TrendingRecipe(id: 3, title: "Authentic Fettuccine Alfredo", image: "spaghetti", timeTaken: 30, rating: 5.0, numberOfIngerdients: 6)
        ]
        onDataUpdated?()
    }
    
    var onDataUpdated: (() -> Void)?
}
