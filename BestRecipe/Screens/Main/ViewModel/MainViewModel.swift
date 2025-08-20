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
        Recipe(id: 1, title: "Grilled Eggplant Salad", image: "eggplantSalad", readyInMinutes: 30, servings: 3, sourceName: "", sourceUrl: "", healthScore: 8.2, creator: Creator(name: "Zeelicious Recipes", profileImageUrl: "chef")),
        Recipe(id: 2, title: "Smash NYC Burger", image: "burger", readyInMinutes: 45, servings: 2, sourceName: "", sourceUrl: "", healthScore: 5.8, creator: Creator(name: "Zeelicious Recipes", profileImageUrl: "chef")),
        Recipe(id: 3, title: "Summer Coleslaw Sandwich", image: "sandwich", readyInMinutes: 10, servings: 4, sourceName: "", sourceUrl: "", healthScore: 7, creator: Creator(name: "Zeelicious Recipes", profileImageUrl: "chef"))
    ]
    
    var onDataUpdated: (() -> Void)?
    
    func loadMockData() {
        onDataUpdated?()
    }
    
}
