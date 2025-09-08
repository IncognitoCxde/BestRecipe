//
//  ViewController.swift
//  BestRecipe
//
//  Created by iMacbook on 8/15/25.
//

// MARK: - Imports

import UIKit
import SnapKit

// MARK: - Controller

class MainViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Variables
    
    let titleLabel = UILabel()
    let titleLabel2 = UILabel()
    let searchBar = UISearchBar()
    let trendingLabel = UILabel()
    let seeAllButton = UIButton()
    var viewModel = MainViewModel()
    var ultimateCollectionView: UICollectionView!
    
    let networkingManager : HomeNetworkingProtocol = HomeNetworkingManager()
    
    var selectedIndexPath: IndexPath?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        tabBarController?.tabBar.dropShadow()        
    }
    
    // MARK: - UI
    
    func setUpUI() {
        view.backgroundColor = .white
        configureNavTitle()
        configureSearchBar()
        bindViewModel()
        configureUltimateCollectionView()
    }
    
    // MARK: - Navigation
    
    func configureNavTitle() {
        titleLabel.text = "Get amazing recipes \nfor cooking"
        titleLabel.textColor = UIColor(named: "Neutal 100")
        titleLabel.font = UIFont(name: AppFont.SemiBold, size: 27)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalTo(80)
        }
        
    }
    
    // MARK: - Search Bar
    
    func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = " Search recipes"
        searchBar.layer.borderWidth = 1
        searchBar.searchTextField.font = UIFont(name: AppFont.Regular, size: 17)
        
        searchBar.layer.borderColor = UIColor.neutral50.cgColor
        searchBar.layer.cornerRadius = 12
        searchBar.layer.masksToBounds = true
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.backgroundColor = .clear
        }
        
        if let customSearchImage = UIImage(named: "Union") {
            searchBar.setImage(customSearchImage, for: .search, state: .normal)
            
        }
        
        view.addSubview(searchBar)
        
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(180)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Trending Collection View
    
    func configureUltimateCollectionView() {
        ultimateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        ultimateCollectionView.dataSource = self
        ultimateCollectionView.delegate = self
        ultimateCollectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        ultimateCollectionView.register(PopularCategoryCollectionViewCell.self, forCellWithReuseIdentifier: PopularCategoryCollectionViewCell.identifier)
        ultimateCollectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        ultimateCollectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.identifier)
        ultimateCollectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.identifier
        )
        
        ultimateCollectionView.backgroundColor = .clear
        view.addSubview(ultimateCollectionView)
        
        ultimateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
        
    }
    
    // MARK: - Data Centre
    
    func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.ultimateCollectionView.reloadData()
            }
        }
        viewModel.fetchData {
            self.ultimateCollectionView.reloadData()
        }
    }
    
    // MARK: - Compositional Layout
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let sectionType = RecipeSectionType(rawValue: sectionIndex) else { return nil }
            switch sectionType {
            case .trending:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(0.9)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.6),
                    heightDimension: .absolute(250)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 20
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 40, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(54))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [sectionHeader]
                
                return section
            case .popular:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(0.9)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(150)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: -9, leading: 16, bottom: 70, trailing: 16)
                
                return section
                
            case .popularCategories:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(0.3)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .absolute(100)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 5
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(54))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            
            case .recent:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.3),
                    heightDimension: .fractionalHeight(0.9)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.6),
                    heightDimension: .absolute(250)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 20
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(54))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                
                section.boundarySupplementaryItems = [sectionHeader]
                
                return section
            }
            
        }
    }
    
    @objc private func resetOnboarding() {
        UserDefaults.standard.removeObject(forKey: "hasSeenOnboarding")
        UserDefaults.standard.synchronize()
        print("🔄 Онбординг сброшен")
        
        if let window = view.window {
            let storage = OnboardingStorage()
            let coordinator = AppCoordinator(window: window, storage: storage)
            coordinator.start()
        }
    }
}



// MARK: - Data Source

extension MainViewController: UICollectionViewDataSource, SectionHeaderReusableViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return RecipeSectionType.allCases.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionType = RecipeSectionType(rawValue: section) else { return 0 }
        switch sectionType {
        case .trending:
            return viewModel.trendingRecipes.count
        case.popularCategories:
            return viewModel.categories.count
        case .popular:
            return viewModel.allPopularRecipes.count
        case .recent:
            return viewModel.recentRecipes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionType = RecipeSectionType(rawValue: indexPath.section) else { fatalError() }
        
        switch sectionType {
        case .trending:
            let recipe = viewModel.trendingRecipes[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
            cell.configure(with: recipe)
            return cell
        case .popular:
            let recipe = viewModel.allPopularRecipes[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as! PopularCollectionViewCell
            cell.configure(with: recipe)
            return cell
        case .popularCategories:
            let categories = viewModel.categories[indexPath.item].name
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoryCollectionViewCell.identifier, for: indexPath) as! PopularCategoryCollectionViewCell
            
            let isSelected = indexPath == selectedIndexPath
            
            if indexPath == selectedIndexPath {
                cell.label.font = UIFont(name: AppFont.SemiBold, size: 17)
                cell.label.textColor = .primary60
            } else {
                cell.label.font = UIFont(name: AppFont.SemiBold, size: 15)
                cell.label.textColor = .primary30
            }
            
            cell.configure(with: categories, isSelected: isSelected)
            return cell
        case .recent:
            let recipe = viewModel.recentRecipes[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifier, for: indexPath) as! RecentCollectionViewCell
            cell.configure(with: recipe)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderReusableView.identifier,
            for: indexPath
        ) as! SectionHeaderReusableView
        
        if indexPath.section == 0 {
            header.configure(title: "Trending Now 🔥", showButton: true, section: indexPath.section, delegate: self)
        } else if indexPath.section == 1 {
            header.configure(title: "Popular Categories", showButton: false, section: indexPath.section, delegate: self)
        } else if indexPath.section == 3 {
            header.configure(title: "Recent recipes", showButton: true, section: indexPath.section, delegate: self)
        } else {
            header.configure(title: "", showButton: false, section: indexPath.section, delegate: self)
        }
        
        return header
    }
    
    func sectionHeaderReusableViewDidTapSeeAll(in section: Int) {
        if section == 0 {
            let tvc = TrendingRecipesViewController()
            navigationController?.pushViewController(tvc, animated: true)
        } else if section == 3 {
            let rvc = RecentRecipesViewController()
            navigationController?.pushViewController(rvc, animated: true)
        } else {
            
        }
    }
    
}

// MARK: - Delegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = RecipeSectionType(rawValue: indexPath.section)!
        switch section {
        case .popularCategories:
            let category = viewModel.categories[indexPath.item]
            viewModel.fetchRecipes(for: category) {
                collectionView.reloadSections(IndexSet(integer: RecipeSectionType.popular.rawValue))
            }

            let previousIndexPath = selectedIndexPath
            selectedIndexPath = indexPath
            
            var indexPathsToReload = [indexPath]
            if let previous = previousIndexPath, previous != indexPath {
                indexPathsToReload.append(previous)
            }
            
            collectionView.reloadItems(at: indexPathsToReload)
            
        case .trending, .popular:
            let recipe = (section == .trending) ?
                viewModel.trendingRecipes[indexPath.item] :
                viewModel.allPopularRecipes[indexPath.item]
            
            if let existingIndex = viewModel.recentRecipes.firstIndex(where: { $0.id == recipe.id }) {
                viewModel.recentRecipes.remove(at: existingIndex)
            }

            viewModel.recentRecipes.insert(recipe, at: 0)
            collectionView.reloadSections(IndexSet(integer: RecipeSectionType.recent.rawValue))
            
            let recipeId = recipe.id
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

        case .recent:
            let recipe = (section == .recent) ?
            viewModel.recentRecipes[indexPath.item]:
            viewModel.trendingRecipes[indexPath.item]
            viewModel.allPopularRecipes[indexPath.item]
            
            let recipeId = recipe.id
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
}
