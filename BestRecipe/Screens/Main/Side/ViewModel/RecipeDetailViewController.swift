//
//  RecipeDetailViewController.swift
//  BestRecipe
//
//  Created by iMacbook on 9/5/25.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    private let recipe: RecipeDetail

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let instructionsLabel = UILabel()

    init(recipe: RecipeDetail) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        titleLabel.text = recipe.title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0

        instructionsLabel.text = recipe.instructions ?? "No instructions available."
        instructionsLabel.numberOfLines = 0
        instructionsLabel.lineBreakMode = .byWordWrapping

        imageView.setImage(from: recipe.image)

        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, instructionsLabel])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
