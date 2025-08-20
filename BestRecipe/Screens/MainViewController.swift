import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private var categories: [RecipeCategory] = []
    private var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupData()
        setupTableView()
        setupCollectionView()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Лучшие рецепты"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.configureForRecipes()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.configureForCategories()
    }
    
    private func setupData() {
        categories = [
            RecipeCategory(name: "Завтрак", recipeCount: 25, imageName: nil),
            RecipeCategory(name: "Обед", recipeCount: 42, imageName: nil),
            RecipeCategory(name: "Ужин", recipeCount: 38, imageName: nil),
            RecipeCategory(name: "Десерты", recipeCount: 31, imageName: nil),
            RecipeCategory(name: "Напитки", recipeCount: 19, imageName: nil),
            RecipeCategory(name: "Салаты", recipeCount: 27, imageName: nil)
        ]
        
        recipes = [
            Recipe(title: "Паста Карбонара", cookingTime: 25, difficulty: "Легко", rating: 5, imageName: nil),
            Recipe(title: "Салат Цезарь", cookingTime: 15, difficulty: "Легко", rating: 4, imageName: nil),
            Recipe(title: "Тирамису", cookingTime: 45, difficulty: "Средне", rating: 5, imageName: nil),
            Recipe(title: "Суп Том Ям", cookingTime: 35, difficulty: "Средне", rating: 4, imageName: nil),
            Recipe(title: "Стейк Рибай", cookingTime: 20, difficulty: "Сложно", rating: 5, imageName: nil)
        ]
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueRecipeCell(for: indexPath)
        let recipe = recipes[indexPath.row]
        cell.configure(with: recipe)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCategoryCell(for: indexPath)
        let category = categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<categories.count { categories[i].isSelected = false }
        categories[indexPath.row].isSelected = true
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CategoryCell.size
    }
}

import SnapKit

