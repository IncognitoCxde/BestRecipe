import Foundation

protocol PersistenceService {
    func save(recipe: Recipe) async throws
    func loadRecipes() async throws -> [Recipe]
    func deleteRecipe(id: UUID) async throws
}

final class InMemoryPersistenceService: PersistenceService, @unchecked Sendable {
    static let shared = InMemoryPersistenceService()
    
    private var storage: [UUID: Recipe] = [:]
    private let queue = DispatchQueue(label: "InMemoryPersistenceService", qos: .userInitiated)
    
    private init() {}
    
    func save(recipe: Recipe) async throws {
        try await withCheckedThrowingContinuation { continuation in
            queue.async {
                self.storage[recipe.id] = recipe
                continuation.resume()
            }
        }
    }
    
    func loadRecipes() async throws -> [Recipe] {
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
