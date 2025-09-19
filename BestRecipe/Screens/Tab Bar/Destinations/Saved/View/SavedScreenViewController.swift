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
    
    private var horizontalInset: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Saved Recipes"
        if let customFont = UIFont(name: AppFont.semiBold, size: 24) {
            label.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: customFont)
        }
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .neutral100
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "You have no saved recipes yet."
        label.font = UIFont(name: AppFont.regular, size: 17)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .neutral50
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        view.addSubview(emptyStateLabel)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(RecipeCell.self, forCellReuseIdentifier: "RecipeCell")
    }
    
    // MARK: Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.trailing.equalToSuperview().inset(horizontalInset)
        }

        emptyStateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
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
                self?.updateUIForEmptyState()
            }
        }
    }
    
    private func updateUIForEmptyState() {
        let hasRecipes = !viewModel.recipes.isEmpty
        tableView.isHidden = !hasRecipes
        emptyStateLabel.isHidden = hasRecipes
    }

    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < viewModel.recipes.count else {
            return UITableViewCell() 
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }

        let recipe = viewModel.recipes[indexPath.row]
        cell.configure(with: recipe)

        cell.saveButton.onToggle = { [weak self] in
            self?.viewModel.removeRecipe(withID: recipe.id) { _ in
                self?.tableView.reloadData()
                self?.updateUIForEmptyState()
            }
        }

        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = viewModel.recipes[indexPath.row]
        viewModel.fetchRecipeDetail(for: selectedRecipe.id) { [weak self] detail in
            guard let self = self, let detail = detail else { return }

            DispatchQueue.main.async {
                let detailViewModel = RecipeDetailViewModel(recipe: detail)
                let detailsVC = RecipeDetailsViewController()
                detailsVC.viewModel = detailViewModel
                self.navigationController?.pushViewController(detailsVC, animated: true)
            }
        }
    }



}
