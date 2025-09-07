//
//  RecipeDetailsViewController.swift
//  BestRecipe
//
//  Created by Irina  on 24/08/25.
//

import UIKit
import SnapKit

class RecipeDetailsViewController: UIViewController {

    // MARK: - Properties
    var recipeIngredients: [ingredient] = []
    var viewModel: RecipeDetailViewModel!

    // MARK: - UI Elements
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFont.SemiBold, size: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let starImageView = UIImageView()
        starImageView.image = UIImage(named: "Star")
        starImageView.tintColor = .neutral100
        starImageView.contentMode = .scaleAspectFit
        starImageView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
        }

        let ratingValueLabel = UILabel()
        ratingValueLabel.font = UIFont(name: AppFont.SemiBold, size: 16)
        ratingValueLabel.textColor = .neutral100

        let reviewsLabel = UILabel()
        reviewsLabel.font = UIFont(name: AppFont.Regular, size: 16)
        reviewsLabel.textColor = .neutral50
        reviewsLabel.text = ""

        let textStack = UIStackView(arrangedSubviews: [ratingValueLabel, reviewsLabel])

        let mainStack = UIStackView(arrangedSubviews: [starImageView, textStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 3
        mainStack.alignment = .center
        return mainStack
    }()

    
    private let instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Instructions"
        label.font = UIFont(name: AppFont.SemiBold, size: 20)
        return label
    }()
    
    private let instructionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = UIFont(name: AppFont.SemiBold, size: 20)
        return label
    }()
    
    private let ingredientsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupCustomBackButton()
        bindViewModel()
    }
    
    // MARK: - UI Setup & Constraints
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(recipeImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(ratingStackView)
        mainStackView.addArrangedSubview(instructionsTitleLabel)
        mainStackView.addArrangedSubview(instructionsStackView)
        mainStackView.addArrangedSubview(ingredientsTitleLabel)
        mainStackView.addArrangedSubview(ingredientsStackView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        recipeImageView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(343)

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
    
    // MARK: - Data Binding
    
    private func bindViewModel() {
        guard viewModel != nil else { return }
        
        titleLabel.text = viewModel.recipeTitle
        if let textStack = ratingStackView.arrangedSubviews[1] as? UIStackView,
           let ratingLabel = textStack.arrangedSubviews[0] as? UILabel,
           let reviewsLabel = textStack.arrangedSubviews[1] as? UILabel {

            ratingLabel.text = viewModel.recipeRatingText
            reviewsLabel.text = viewModel.recipeReviewsText
        }


        if let imageUrlString = viewModel.recipe.image,
           let url = URL(string: imageUrlString) {
            ImageLoader.shared.loadImage(from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.recipeImageView.image = image ?? UIImage(systemName: "square.dashed")
                    self?.recipeImageView.tintColor = image == nil ? .neutral60 : nil
                }
            }
        } else {
            recipeImageView.image = UIImage(systemName: "square.dashed")
            recipeImageView.tintColor = .neutral60
        }

        
        for (index, instruction) in viewModel.recipeInstructions.enumerated() {
            let instructionLabel = UILabel()
            instructionLabel.font = UIFont(name: AppFont.Regular, size: 16)
            instructionLabel.text = "\(index + 1) \(instruction)".htmlStripped
            instructionLabel.numberOfLines = 0
            instructionsStackView.addArrangedSubview(instructionLabel)
        }
        
        for ingredient in viewModel.recipeIngredients {
            let ingredientView = IngredientView(ingredient: ingredient)
            ingredientsStackView.addArrangedSubview(ingredientView)
        }

    }
}
