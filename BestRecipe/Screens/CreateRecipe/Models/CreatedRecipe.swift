import Foundation
import UIKit

struct CreatedIngredient: Hashable, Codable, Sendable {
    let id: UUID
    var name: String
    var quantity: String
    
    init(name: String, quantity: String) {
        self.id = UUID()
        self.name = name
        self.quantity = quantity
    }
}

struct CreatedRecipe: Hashable, Codable, Sendable {
    let id: UUID
    var title: String
    var serves: Int
    var cookTimeMinutes: Int
    var ingredients: [CreatedIngredient]
    var imageData: Data?
    
    init(title: String, serves: Int, cookTimeMinutes: Int, ingredients: [CreatedIngredient], imageData: Data? = nil) {
        self.id = UUID()
        self.title = title
        self.serves = serves
        self.cookTimeMinutes = cookTimeMinutes
        self.ingredients = ingredients
        self.imageData = imageData
    }
}

extension CreatedRecipe {
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
