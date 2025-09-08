//
//  RecipeViewController.swift
//  BestRecipe
//
//  Created by iMacbook on 8/23/25.
//

import UIKit

class TrendingRecipesViewController: UIViewController {

    // MARK: - Variables
    
    let trendingTitle = UILabel()
    let trendingTableView = UITableView()
    var viewModel = SideViewModel()
    let networkingManager: HomeNetworkingProtocol = HomeNetworkingManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setUpUI()
    }
    
    // MARK: - UI
    
    private func setUpUI() {
        setupCustomBackButton()
        setUpTitle()
        bindViewModel()
        setUpTrendingTableView()
        configureConstraints()
        
    }
    
    private func setupCustomBackButton() {
        let backButton = UIButton(type: .system)
        let icon = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(icon, for: .normal)
        backButton.tintColor = .neutral100
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: - Data Centre
    
    func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.trendingTableView.reloadData()
            }
        }
        viewModel.fetchData {
            self.trendingTableView.reloadData()
        }
    }
    
    func setUpTitle() {
        trendingTitle.text = "Trending Now"
        trendingTitle.font = UIFont(name: AppFont.SemiBold, size: 25)
        trendingTitle.textColor = .neutral100
        trendingTitle.textAlignment = .center
        view.addSubview(trendingTitle)
    }
    
    
    func setUpTrendingTableView() {
        trendingTableView.separatorStyle = .none
        trendingTableView.backgroundColor = .clear
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        trendingTableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        view.addSubview(trendingTableView)
    }
    
    // MARK: - Constraints
    
    func configureConstraints() {
        trendingTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.equalToSuperview().inset(110)
        }
        
        trendingTableView.snp.makeConstraints { make in
            make.top.equalTo(trendingTitle.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Data Source

extension TrendingRecipesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.trendingRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as? TrendingTableViewCell else {
            return UITableViewCell()
        }
        let recipe = viewModel.trendingRecipes[indexPath.row]
        cell.configure(with: recipe)
        
        return cell
    }
    
}

// MARK: - Delegate

extension TrendingRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeId = viewModel.trendingRecipes[indexPath.row].id ?? 0
        networkingManager.fetchRecipeDetail(id: recipeId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let detail):
                    let detailVC = RecipeDetailViewController(recipe: detail)
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                case .failure(let error):
                    print("Failed to fetch recipe details:", error)
                }
            }
        }
    }
}
