//
//  RecipeCell.swift
//  BestRecipe
//
//  Created by Administration  on 22/08/25.
//

import UIKit
import SnapKit

class RecipeCell: UITableViewCell {

    // MARK: - UI Elements
    
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        stackView.layer.cornerRadius = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        return stackView
    }()
    
    private let ratingIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        self.selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    
    private func setupViews() {
        contentView.addSubview(recipeImageView)
        contentView.addSubview(titleLabel)
        
        ratingStackView.addArrangedSubview(ratingIcon)
        ratingStackView.addArrangedSubview(ratingLabel)
        
        recipeImageView.addSubview(ratingStackView)
        recipeImageView.addSubview(saveButton)
        recipeImageView.addSubview(timeLabel)
    }
    
    private func setupConstraints() {
        recipeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(35)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        ratingStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(10)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.width.height.equalTo(30)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(10)
            make.height.equalTo(25)
            make.width.equalTo(60)
        }
    }
    
    // MARK: - Public Methods
    
    func configure(with recipe: Recipe) {
        recipeImageView.image = UIImage(named: recipe.imageName)
        titleLabel.text = recipe.title
        ratingLabel.text = "\(recipe.rating)"
        timeLabel.text = recipe.time
    }
}
