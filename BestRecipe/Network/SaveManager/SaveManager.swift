//
//  SaveManager.swift
//  BestRecipe
//
//  Created by Administration  on 06/09/25.
//

import Foundation

final class SaveManager {
    
    static let shared = SaveManager()
    private let key = "favorite_recipe_ids"

    private init() {}

    func getFavorites() -> [Int] {
        UserDefaults.standard.array(forKey: key) as? [Int] ?? []
    }

    func add(id: Int) {
        var favorites = getFavorites()
        guard !favorites.contains(id) else { return }
        favorites.append(id)
        UserDefaults.standard.set(favorites, forKey: key)
    }

    func remove(id: Int) {
        var favorites = getFavorites()
        favorites.removeAll { $0 == id }
        UserDefaults.standard.set(favorites, forKey: key)
    }

    func toggle(id: Int) {
        if isFavorite(id: id) {
            print("Removing recipe \(id)")
            remove(id: id)
        } else {
            print("Adding recipe \(id)")
            add(id: id)
        }

        print("Current favorites: \(getFavorites())")
    }


    func isFavorite(id: Int) -> Bool {
        return getFavorites().contains(id)
    }

}
