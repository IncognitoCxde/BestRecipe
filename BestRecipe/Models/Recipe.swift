import Foundation
import UIKit

struct Ingredient: Hashable, Codable {
    let id: UUID
    var name: String
    var quantity: String
    
    init(name: String, quantity: String) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
    }
}

struct Recipe: Hashable, Codable {
    let id: UUID
    var title: String
    var serves: Int
    var cookTimeMinutes: Int
    var ingredients: [Ingredient]
    var imageData: Data?
    
    init(title: String, serves: Int, cookTimeMinutes: Int, ingredients: [Ingredient], imageData: Data? = nil) {
        self.id = UUID()
        self.title = title
        self.serves = serves
        self.cookTimeMinutes = cookTimeMinutes
        self.ingredients = ingredients
        self.imageData = imageData
    }
}

extension Recipe {
    var ingredientsCount: Int {
        ingredients.count
    }
    
    var cookTimeText: String {
        "\(cookTimeMinutes) min"
    }
    
    var ingredientsText: String {
        "\(ingredientsCount) Ingredients"
    }
}
