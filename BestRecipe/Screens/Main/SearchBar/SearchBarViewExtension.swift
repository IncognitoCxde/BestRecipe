//
//  SearchBarViewExtension.swift
//  BestRecipe
//
//  Created by iMacbook on 9/17/25.
//

import UIKit

let mainVC = MainViewController()
let networkingManager = HomeNetworkingManager()


extension SearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            mainVC.ultimateCollectionView.isHidden = false
            mainVC.resultsTableView.isHidden = true
            mainVC.results.removeAll()
            return
        } else {
            mainVC.ultimateCollectionView.isHidden = true
            mainVC.resultsTableView.isHidden = false
            
            let group = DispatchGroup()
            
            group.enter()
            networkingManager.fetchSearchedRecipes(query: searchText) { [weak self] result in
                defer { group.leave() }
                guard self != nil else { return }
                switch result {
                case .success(let response):
                    mainVC.results = response.results ?? []
                case .failure(let error):
                    print("Error fetching trending recipes: \(error)")
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        delegate?.endSearch()
    }
}
