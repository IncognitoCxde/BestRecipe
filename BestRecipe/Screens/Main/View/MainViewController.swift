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
    let viewModel = MainViewModel()
    var trendingCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    // MARK: - UI
    
    func setUpUI() {
        view.backgroundColor = .white
        configureNavTitle()
        configureSearchBar()
        configureTrendingLabel()
        configureSeeAllButton()
        configureTrendingCollectionView()
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
       
        searchBar.layer.borderColor = UIColor(named: "Neutral 50")?.cgColor
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
    
    // MARK: - Trending label & See all
    
    func configureTrendingLabel() {
        trendingLabel.text = "Trending now 🔥"
        trendingLabel.font = UIFont(name: AppFont.SemiBold, size: 20)
        trendingLabel.textColor = UIColor(named: "Neutral 100")
        view.addSubview(trendingLabel)
        
        trendingLabel.snp.makeConstraints { make in
            make.top.equalTo(250)
            make.leading.equalToSuperview().inset(30)
        }
    }
    
    func configureSeeAllButton() {
        seeAllButton.setTitle("See all", for: .normal)
        seeAllButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        seeAllButton.tintColor = UIColor(named: "Neutral 100")
        seeAllButton.setTitleColor(UIColor(named: "Primary 50"), for: .normal)
        seeAllButton.semanticContentAttribute = .forceRightToLeft

        seeAllButton.titleLabel?.font = UIFont(name: AppFont.SemiBold, size: 17)
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        view.addSubview(seeAllButton)
        
        seeAllButton.snp.makeConstraints { make in
            make.top.equalTo(250)
            make.trailing.equalToSuperview().inset(20)
            
        }
    }
    
    // Button action
    @objc func seeAllButtonTapped() {
        print("transfer user to see all page")
    }
    
    // MARK: - Trending Collection View
    
    func configureTrendingCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 300, height: 200)
        layout.scrollDirection = .horizontal
        trendingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        trendingCollectionView.dataSource = self
        trendingCollectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        view.addSubview(trendingCollectionView)
        
        viewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.trendingCollectionView.reloadData()
            }
        }
        viewModel.loadMockData()
        
        trendingCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(230)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(330)
        }
        
        trendingCollectionView.backgroundColor = .clear
    }
    
}

// MARK: - Trending Collection View Delegate

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.trendingRecipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
        let recipe = viewModel.trendingRecipes[indexPath.item]
        cell.configure(with: recipe)
        return cell
    }
}
