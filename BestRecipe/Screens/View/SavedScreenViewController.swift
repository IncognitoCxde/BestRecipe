//
//  SavedScreenViewController.swift
//  BestRecipe
//
//  Created by Administration  on 21/08/25.
//

import UIKit
import SnapKit

class SavedScreenViewController: UIViewController {
    
    // MARK: Properties
    private let titleScreen: UILabel = {
        let label = UILabel()
        label.text = "Saved Recipes"
        label.font = UIFont(name: "SemiBold", size: 24) ?? .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = UIColor(named: "Neutral 100")
        return label
    }()
    
    private var savedRecipes: [Recipe] = []
    
    // MARK: Lifesycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleScreen)
        setupConstraints()

    }
    
    // MARK: Consraints
    
    private func setupConstraints() {
        titleScreen.snp.makeConstraints() { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
