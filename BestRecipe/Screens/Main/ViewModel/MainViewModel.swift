//
//  MainViewModel.swift
//  BestRecipe
//
//  Created by iMacbook on 8/19/25.
//

import UIKit

class MainViewModel {
    // Mock data 4 now
    var trendingRecipes: [Recipe] = [
        Recipe(id: 1, title: "Spicy Salmon with edamame", image: "salmon", readyInMinutes: 40, servings: 3, sourceName: "", sourceUrl: "", healthScore: 8.2, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef")),
        Recipe(id: 2, title: "The Perfect Steak", image: "steak", readyInMinutes: 45, servings: 2, sourceName: "", sourceUrl: "", healthScore: 7.2, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef")),
        Recipe(id: 3, title: "Authentic Fettuccine Alfredo", image: "spaghetti", readyInMinutes: 30, servings: 4, sourceName: "", sourceUrl: "", healthScore: 6, creator: Creator(name: "Zeelicious Foods", profileImageUrl: "chef"))
    ]
    
    var onDataUpdated: (() -> Void)?
    
    func loadMockData() {
        onDataUpdated?()
    }
    
}
