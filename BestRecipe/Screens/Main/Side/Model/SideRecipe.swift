
#warning("тут не нужен UIKit")
import UIKit

struct SideRecipe: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let timeTaken: Int?
    let rating: Double?
    let numberOfIngredients: Int?
}

struct FullRecipeResponse: Codable {
    var results: [SideRecipe]?
}
