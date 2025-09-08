import Foundation

protocol PersistenceService {
    func save(recipe: CreatedRecipe) async throws
    func loadRecipes() async throws -> [CreatedRecipe]
    func deleteRecipe(id: UUID) async throws
}

final class InMemoryPersistenceService: PersistenceService, @unchecked Sendable {
    static let shared = InMemoryPersistenceService()
    
    private var storage: [UUID: CreatedRecipe] = [:]
    private let queue = DispatchQueue(label: "InMemoryPersistenceService", qos: .userInitiated)
    
    private init() {}
    
    func save(recipe: CreatedRecipe) async throws {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                self.storage[recipe.id] = recipe
                continuation.resume()
            }
        }
    }
    
    func loadRecipes() async throws -> [CreatedRecipe] {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                let recipes = Array(self.storage.values).sorted { $0.title < $1.title }
                continuation.resume(returning: recipes)
            }
        }
    }
    
    func deleteRecipe(id: UUID) async throws {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                self.storage.removeValue(forKey: id)
                continuation.resume()
            }
        }
    }
}
