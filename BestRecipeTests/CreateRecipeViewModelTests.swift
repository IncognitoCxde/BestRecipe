import XCTest
@testable import BestRecipe

final class CreateRecipeViewModelTests: XCTestCase {
    func testValidationFailsWhenNoTitleOrIngredients() {
        let vm = CreateRecipeViewModel(persistence: InMemoryPersistenceService.shared)
        let out = vm.validate()
        XCTAssertFalse(out.isValid)
    }

    func testValidationPassesWithTitleAndIngredient() {
        let vm = CreateRecipeViewModel(persistence: InMemoryPersistenceService.shared)
        vm.updateTitle("Pasta")
        vm.addIngredient(name: "Noodles", quantity: "200g")
        XCTAssertTrue(vm.validate().isValid)
    }
}




