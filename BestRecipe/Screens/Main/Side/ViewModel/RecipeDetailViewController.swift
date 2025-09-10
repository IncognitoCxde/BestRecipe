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
    private let instructionsTitle = UILabel()
    private let instructionsLabel = UILabel()
    private let ingredientsTitle = UILabel()
    
    private let ingredientsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()


    init(recipe: RecipeDetail) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
        setupCustomBackButton()
    }
    

    func setUpUI() {
        let scrollView = UIScrollView()
        scrollView.bouncesVertically = true
        scrollView.showsVerticalScrollIndicator = true
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(25)
        }
        
        titleLabel.text = recipe.title
        titleLabel.font = UIFont(name: AppFont.semiBold, size: 20)
        titleLabel.numberOfLines = 0
        
        instructionsTitle.text = "Instructions"
        instructionsTitle.font = UIFont(name: AppFont.semiBold, size: 20)
        
        instructionsLabel.text = recipe.instructions?.htmlStripped ?? "No instructions available"
        instructionsLabel.numberOfLines = 0
        instructionsLabel.lineBreakMode = .byWordWrapping
        instructionsLabel.font = UIFont(name: AppFont.regular, size: 16)

        imageView.setImage(from: recipe.image)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(230)
            make.width.equalTo(343)
        }
        
        ingredientsTitle.text = "Ingredients"
        ingredientsTitle.font = UIFont(name: AppFont.semiBold, size: 20)
        
        for ingredient in recipe.extendedIngredients {
            let ingredientView = IngredientCustomView(ingredient: ingredient)
            ingredientsStackView.addArrangedSubview(ingredientView)
        }
        
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel,instructionsTitle, instructionsLabel, ingredientsTitle, ingredientsStackView])
        
        stack.axis = .vertical
        stack.spacing = 16
        
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(contentView)
        }
    }
    
    private func setupCustomBackButton() {
        let backButton = UIButton(type: .system)
        let icon = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(icon, for: .normal)
        backButton.tintColor = .neutral100
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }


    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
