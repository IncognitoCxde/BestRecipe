//
//  SearchBarView.swift
//  BestRecipe
//
//  Created by iMacbook on 9/17/25.
//

import UIKit

final class SearchBarView: UIView {
    
    weak var delegate: SearchBarViewDelegate?
    
    // MARK: - UI
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        let image = UIImage(systemName: Constants.searchIcon)?.withTintColor(.clear, renderingMode: .alwaysOriginal)
        search.setImage(image, for: .search, state: .normal)
        search.placeholder = Constants.placeholder
        search.searchTextField.font = UIFont(name: AppFont.regular, size: 17)
        search.layer.borderWidth = 1
        search.layer.borderColor = UIColor.neutral50.cgColor
        search.layer.cornerRadius = 12
        search.layer.masksToBounds = true
        
        if let searchTextField = search.value(forKey: "searchField") as? UITextField {
            searchTextField.backgroundColor = .clear
        }
        
        if let customSearchImage = UIImage(named: "Union") {
            search.setImage(customSearchImage, for: .search, state: .normal)
            
        }
        
        return search
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpConstraints()
    }
    
    
    private func setUpConstraints() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupDelegate() {
        searchBar.delegate = self
    }

}
