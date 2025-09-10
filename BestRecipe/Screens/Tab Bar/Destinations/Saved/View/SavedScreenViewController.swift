//
//  SavedScreenViewController.swift
//  BestRecipe
//
//  Created by Irina  on 21/08/25.
//

import UIKit
import SnapKit

class SavedScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    private let viewModel = SavedRecipesViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Saved Recipes"
        label.font = UIFont(name: AppFont.semiBold, size: 24)
        label.textColor = .neutral100
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadSavedRecipes()
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
                self?.tableView.reloadData()            }
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
        cell.saveButton.recipeID = recipe.id
        cell.saveButton.onToggle = { [weak self] in
            guard let self = self else { return }
            if let index = self.viewModel.recipes.firstIndex(where: { $0.id == recipe.id }) {
                self.viewModel.recipes.remove(at: index)
                self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        }
        return cell
    }


    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = viewModel.recipes[indexPath.row]
        viewModel.fetchRecipeDetail(for: selectedRecipe.id) { [weak self] detail in
            guard let detail = detail else {
                return
            }
            let detailViewModel = RecipeDetailViewModel(recipe: detail)
            let detailsVC = RecipeDetailsViewController()
            detailsVC.viewModel = detailViewModel
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(detailsVC, animated: true)
            }
        }
    }


}
