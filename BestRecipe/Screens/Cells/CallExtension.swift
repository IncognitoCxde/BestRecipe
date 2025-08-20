//
//  CallExtension.swift
//  BestRecipe
//
//  Created by SORBON AZIMOV on 19/08/25.
//
import UIKit

// MARK: - Identifiers
extension RecipeCell { static let identifier = "RecipeCell" }
extension IngredientCell { static let identifier = "IngredientCell" }
extension StepCell { static let identifier = "StepCell" }
extension CategoryCell { static let identifier = "CategoryCell" }

// MARK: - Sizes
extension RecipeCell { static let height: CGFloat = 120 }
extension IngredientCell { static let height: CGFloat = 60 }
extension StepCell { static let height: CGFloat = 112 }
extension CategoryCell { static let size = CGSize(width: 150, height: 120) }

// MARK: - UITableView helpers
extension UITableView {
    func registerAllRecipeCells() {
        register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.identifier)
        register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.identifier)
        register(StepCell.self, forCellReuseIdentifier: StepCell.identifier)
    }
    func dequeueRecipeCell(for indexPath: IndexPath) -> RecipeCell {
        dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as! RecipeCell
    }
    func dequeueIngredientCell(for indexPath: IndexPath) -> IngredientCell {
        dequeueReusableCell(withIdentifier: IngredientCell.identifier, for: indexPath) as! IngredientCell
    }
    func dequeueStepCell(for indexPath: IndexPath) -> StepCell {
        dequeueReusableCell(withIdentifier: StepCell.identifier, for: indexPath) as! StepCell
    }
    func configureForRecipes() {
        backgroundColor = .systemBackground
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 120
        registerAllRecipeCells()
    }
}

// MARK: - UICollectionView helpers
extension UICollectionView {
    func registerCategoryCell() {
        register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    func dequeueCategoryCell(for indexPath: IndexPath) -> CategoryCell {
        dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
    }
    func configureForCategories() {
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        registerCategoryCell()
    }
}

