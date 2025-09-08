import Foundation

final class CreateRecipeViewModel {
    
    struct Inputs {
        var title: String = ""
        var serves: Int = 1
        var cookTimeMinutes: Int = 10
        var ingredients: [CreatedIngredient] = []
        var imageData: Data? = nil
        var isAddingNewIngredient: Bool = false
    }
    
    var inputs = Inputs()
    private let persistence: PersistenceService
    
    init(persistence: PersistenceService = InMemoryPersistenceService.shared) {
        self.persistence = persistence
    }
    
    func updateTitle(_ title: String) {
        inputs.title = title
    }
    
    func updateServes(_ serves: Int) {
        inputs.serves = serves
    }
    
    func updateCookTime(_ minutes: Int) {
        inputs.cookTimeMinutes = minutes
    }
    
    func updateImage(_ data: Data?) {
        inputs.imageData = data
    }
    
    func addIngredient(name: String, quantity: String) {
        let ingredient = CreatedIngredient(name: name, quantity: quantity)
        inputs.ingredients.append(ingredient)
    }
    
    func removeIngredient(id: UUID) {
        inputs.ingredients.removeAll { $0.id == id }
    }
    
    func toggleAddingNewIngredient() {
        inputs.isAddingNewIngredient.toggle()
    }
    
    func cancelAddingNewIngredient() {
        inputs.isAddingNewIngredient = false
    }
    
    func validate() -> (isValid: Bool, message: String?) {
        let isValid = !inputs.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return (isValid, isValid ? nil : "Recipe title is required")
    }
    
    func createRecipe() async throws -> CreatedRecipe {
        let validation = validate()
        guard validation.isValid else {
            throw RecipeError.invalidData(validation.message ?? "Invalid recipe data")
        }
        
        let recipe = CreatedRecipe(
            title: inputs.title,
            serves: inputs.serves,
            cookTimeMinutes: inputs.cookTimeMinutes,
            ingredients: inputs.ingredients,
            imageData: inputs.imageData
        )
        
        try await persistence.save(recipe: recipe)
        return recipe
    }
}

enum RecipeError: LocalizedError {
    case invalidData(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidData(let message):
            return message
        }
    }
}
