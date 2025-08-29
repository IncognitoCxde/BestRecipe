//
//  SavedScreenViewController.swift
//  BestRecipe
//
//  Created by Administration  on 21/08/25.
//

import UIKit
import SnapKit

class SavedScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    // ViewModel
    private let viewModel = SavedRecipesViewModel()
    
    // UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Saved Recipes"
        label.font = UIFont(name: "SemiBold", size: 24) ?? .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = UIColor(named: "Neutral 100")
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
        bindViewModel()
        
        viewModel.loadSavedRecipes()
        
        let savedViewModel = SavedRecipesViewModel()
        savedViewModel.loadSavedRecipes()

        if let firstRecipe = savedViewModel.recipes.first {
            let detailViewModel = RecipeDetailViewModel(recipe: firstRecipe)
            print(detailViewModel.recipeTitle) 
        }

    }
    
    // MARK: UI Setup
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
    }
    
    // MARK: Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: ViewModel Binding
    
    private func bindViewModel() {
        viewModel.onRecipesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        
        let recipe = viewModel.recipes[indexPath.row]
        cell.configure(with: recipe)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = viewModel.recipes[indexPath.row]
        let viewModel = RecipeDetailViewModel(recipe: selectedRecipe)
        let detailsVC = RecipeDetailsViewController()
        detailsVC.viewModel = viewModel
        navigationController?.pushViewController(detailsVC, animated: true)

    }
}
